defmodule Bloc.Habits do
  @moduledoc """
  The Habits context.
  """

  import Ecto.Query

  alias Bloc.Blocks.Block
  alias Bloc.Habits.Habit
  alias Bloc.Habits.HabitDay
  alias Bloc.Repo
  alias Bloc.Scope
  alias Bloc.Tasks.Task

  require Logger

  @doc """
  Returns the list of habits.

  ## Examples

      iex> list_habits()
      [%Habit{}, ...]

  """
  def list_habits(%Scope{} = scope, opts \\ []) do
    Habit
    |> Bloc.Query.for_scope(scope)
    |> by_period_type(opts[:period_type])
    |> preload(:subhabits)
    |> Repo.all()
  end

  defp by_period_type(query, nil), do: query

  defp by_period_type(query, period_type) do
    where(query, [h], h.period_type == ^period_type)
  end

  @doc """
  Gets a single habit.

  Raises `Ecto.NoResultsError` if the Habit does not exist.

  ## Examples

      iex> get_habit!(123)
      %Habit{}

      iex> get_habit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_habit!(id), do: Repo.get!(Habit, id)

  @doc """
  Creates a habit.

  ## Examples

      iex> create_habit(%{field: value})
      {:ok, %Habit{}}

      iex> create_habit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_habit(attrs, scope) do
    subhabits = Map.get(attrs, "subhabits", [])

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:habit, Habit.changeset(attrs))
    |> Ecto.Multi.run(:subhabits, fn repo, %{habit: habit} ->
      results =
        Enum.map(subhabits, fn subhabit_attrs ->
          subhabit_attrs
          |> Map.merge(%{
            "parent_id" => habit.id,
            "user_id" => habit.user_id,
            "period_type" => habit.period_type,
            "days" => habit.days
          })
          |> Habit.changeset()
          |> repo.insert()
        end)

      if Enum.any?(results, fn {status, _} -> status == :error end) do
        {:error, "Failed to create sub-habits"}
      else
        {:ok, Enum.map(results, fn {_status, subhabit} -> subhabit end)}
      end
    end)
    |> Ecto.Multi.run(:tasks, fn _repo, %{habit: habit, subhabits: subhabits} ->
      insert_tasks_for_habit(habit, subhabits, scope)

      {:ok, :complete}
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{habit: habit}} -> {:ok, habit}
      {:error, _failed_operation, failed_value, _changes} -> {:error, failed_value}
    end
  end

  @spec insert_tasks_for_habit(Habit.t(), Scope.t()) :: Task.t()
  def insert_tasks_for_habit(%Habit{period_type: :daily} = habit, subhabits, %Scope{} = scope) do
    today = TimeUtils.today(scope)
    next_year = Date.new!(today.year + 1, today.month, today.day, today.calendar)
    now = DateTime.truncate(DateTime.utc_now(), :second)

    # Get all dates that match the habit's days
    dates =
      today
      |> Date.range(next_year)
      |> Enum.filter(fn date ->
        Date.day_of_week(date) in (habit.days || [1, 2, 3, 4, 5, 6, 7])
      end)

    # Build task entries for bulk insert
    task_entries =
      Enum.flat_map(dates, fn date ->
        1..habit.required_count
        |> Enum.flat_map(fn _ ->
          parent_task = %{
            id: UUIDv7.generate(),
            title: habit.title,
            habit_id: habit.id,
            user_id: habit.user_id,
            due_date: date,
            inserted_at: now
          }

          subtasks =
            Enum.map(subhabits, fn %Habit{} = subhabit ->
              Map.merge(parent_task, %{
                id: UUIDv7.generate(),
                title: subhabit.title,
                habit_id: subhabit.id,
                user_id: subhabit.user_id,
                parent_id: parent_task.id
              })
            end)

          [parent_task | subtasks]
        end)
      end)

    # Perform bulk task insert
    {count, tasks} = Repo.insert_all(Task, task_entries, returning: [:id, :due_date])

    # If habit has time blocks, create block entries
    if habit.start_time && habit.end_time do
      block_entries =
        Enum.map(tasks, fn task ->
          %{
            id: Ecto.UUID.generate(),
            title: habit.title,
            user_id: habit.user_id,
            task_id: task.id,
            start_time:
              task.due_date |> DateTime.new!(habit.start_time, scope.timezone) |> DateTime.shift_zone!("Etc/UTC"),
            end_time: task.due_date |> DateTime.new!(habit.end_time, scope.timezone) |> DateTime.shift_zone!("Etc/UTC"),
            inserted_at: now,
            updated_at: now
          }
        end)

      {block_count, _} = Repo.insert_all(Block, block_entries)
      Logger.info("Inserted #{block_count} blocks for habit #{habit.id}")
    end

    Logger.info("Inserted #{count} tasks for habit #{habit.id}")
    :ok
  end

  def insert_tasks_for_habit(%Habit{period_type: :monthly} = habit, %Scope{} = scope) do
    # insert on the first day of the month for the year
    today = TimeUtils.today(scope)
    next_year = Date.new!(today.year + 1, today.month, today.day, today.calendar)

    tasks =
      today
      |> Date.range(next_year)
      |> Enum.filter(fn date ->
        date.day == 1
      end)
      |> Enum.map(&task_for_habit_day(habit, &1, scope))
      |> Enum.map(&Repo.insert!/1)

    Logger.info("Inserted #{length(tasks)} tasks for habit #{habit.id}")

    :ok
  end

  def insert_tasks_for_habit(_habit), do: {:ok, []}

  @spec task_for_habit_day(Habit.t(), Date.t(), Scope.t()) :: Changeset.t()
  def task_for_habit_day(%Habit{} = habit, %Date{} = day, %Scope{} = scope) do

    blocks =
      if habit.start_time && habit.end_time do
        [
          %{
            title: habit.title,
            user_id: habit.user_id,
            start_time: day |> DateTime.new!(habit.start_time, scope.timezone) |> DateTime.shift_zone!("Etc/UTC"),
            end_time: day |> DateTime.new!(habit.end_time, scope.timezone) |> DateTime.shift_zone!("Etc/UTC")
          }
        ]
      else
        []
      end

    Task.changeset(%Task{}, %{
      title: habit.title,
      habit_id: habit.id,
      user_id: habit.user_id,
      due_date: day,
      blocks: blocks
    })
  end

  @doc """
  Updates a habit.

  ## Examples

      iex> update_habit(habit, %{field: new_value})
      {:ok, %Habit{}}

      iex> update_habit(habit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_habit(%Habit{} = habit, attrs, %Scope{} = scope) do
    Repo.transaction(fn ->
      # Get the old required count
      old_required_count = habit.required_count
      new_required_count = String.to_integer(attrs["required_count"] || attrs[:required_count])

      diff_required_count = new_required_count - old_required_count

      # Update the habit
      with {:ok, updated_habit} <- habit |> Habit.update_changeset(attrs) |> Repo.update() do
        # If required_count changed, update future tasks
        if diff_required_count != 0 do
          :ok = update_tasks_for_habit(updated_habit, diff_required_count, scope)
        end

        updated_habit
      end
    end)
  end

  defp update_tasks_for_habit(%Habit{} = habit, diff_required_count, %Scope{} = scope) do
    today = TimeUtils.today(scope)

    if diff_required_count > 0 do
      # Create new tasks with updated count
      next_year = Date.new!(today.year + 1, today.month, today.day, today.calendar)

      tasks =
        today
        |> Date.range(next_year)
        |> Enum.flat_map(fn date ->
          Enum.map(1..diff_required_count, fn _ -> task_for_habit_day(habit, date, scope) end)
        end)
        |> Enum.map(&Repo.insert!/1)

      Logger.info("Inserted #{length(tasks)} future tasks for habit #{habit.id}")
    else
      # Get tasks to delete by finding excess tasks for each day
      tasks_to_delete =
        from(t in Task,
          where: t.habit_id == ^habit.id and t.due_date >= ^today,
          select: %{
            id: t.id,
            row_number: over(row_number(), partition_by: [:due_date], order_by: [asc_nulls_first: :complete?])
          }
        )
        |> subquery()
        |> where([t], t.row_number > ^habit.required_count)
        |> select([t], t.id)

      # Delete the identified tasks
      {deleted_count, _} =
        Repo.delete_all(from(t in Task, where: t.id in subquery(tasks_to_delete)))

      Logger.info("Deleted #{deleted_count} excess tasks for habit #{habit.id}")
    end

    :ok
  end

  @doc """
  Deletes a habit.

  ## Examples

      iex> delete_habit(habit)
      {:ok, %Habit{}}

      iex> delete_habit(habit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_habit(%Habit{} = habit) do
    Repo.delete(habit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking habit changes.

  ## Examples

      iex> change_habit(habit)
      %Ecto.Changeset{data: %Habit{}}

  """
  @spec change_create_habit(map) :: Ecto.Changeset.t()
  def change_create_habit(attrs) do
    Habit.changeset(%Habit{}, attrs)
  end

  @spec change_update_habit(Habit.t(), map) :: Ecto.Changeset.t()
  def change_update_habit(%Habit{} = habit, attrs \\ %{}) do
    Habit.update_changeset(habit, attrs)
  end

  def list_habit_days(%Scope{} = scope, %Date{} = start_date, %Date{} = end_date, opts \\ []) do
    HabitDay
    |> Bloc.Query.for_scope(scope)
    |> where([hd], hd.date >= ^start_date and hd.date <= ^end_date)
    |> order_by([hd], asc: hd.date)
    |> Bloc.Query.preloads(opts[:preload])
    |> Repo.all()
  end

  @spec calculate_streak(Habit.t(), Scope.t()) :: {:ok, Habit.t()}
  def calculate_streak(%Habit{} = habit, %Scope{} = scope) do
    today = TimeUtils.today(scope)

    streak =
      from(hd in HabitDay,
        where: hd.habit_id == ^habit.id,
        where: hd.date < ^today,
        where: hd.completed? == true,
        order_by: [desc: :date]
      )
      |> Repo.all()
      |> Enum.reduce_while(0, fn habit_day, streak ->
        if Date.add(habit_day.date, 1) == Date.add(today, -streak) do
          {:cont, streak + 1}
        else
          {:halt, streak}
        end
      end)

    completed_today? =
      Repo.exists?(
        from(hd in HabitDay, where: hd.habit_id == ^habit.id, where: hd.date == ^today, where: hd.completed? == true)
      )

    streak = if completed_today?, do: streak + 1, else: streak

    habit
    |> Habit.update_changeset(%{streak: streak})
    |> Repo.update()
  end

  def calculate_streak(_habit, _scope), do: {:ok, :no_habit}

  def get_or_create_habit_day(%Habit{} = habit, date) do
    case Repo.get_by(HabitDay, habit_id: habit.id, date: date) do
      nil ->
        %HabitDay{}
        |> HabitDay.changeset(%{
          date: date,
          habit_id: habit.id,
          user_id: habit.user_id
        })
        |> Repo.insert()

      %HabitDay{} = habit_day ->
        {:ok, habit_day}
    end
  end

  @spec increment_habit_day_and_calculate_streak(Habit.t(), Scope.t(), Date.t(), Keyword.t()) ::
          {:ok, HabitDay.t()} | {:ok, :no_habit}
  def increment_habit_day_and_calculate_streak(habit, scope, date, opts \\ [])

  def increment_habit_day_and_calculate_streak(%Habit{} = habit, %Scope{} = scope, date, opts) do
    Repo.transaction(fn ->
      with {:ok, habit_day} <- get_or_create_habit_day(habit, date),
           {:ok, updated_day} <- update_habit_day_count(habit_day, habit, scope, opts) do
        updated_day
      end
    end)
  end

  def increment_habit_day_and_calculate_streak(_habit, _scope, _date, _opts), do: {:ok, :no_habit}

  defp update_habit_day_count(%HabitDay{} = habit_day, habit, scope, opts) do
    change = if opts[:decrement?], do: -1, else: 1
    new_count = habit_day.completed_count + change
    completed? = new_count >= habit.required_count

    with {:ok, habit_day} <-
           habit_day
           |> HabitDay.changeset(%{
             completed_count: new_count,
             completed?: completed?
           })
           |> Repo.update(),
         {:ok, _habit} <- calculate_streak(habit, scope) do
      habit_day
    end
  end
end
