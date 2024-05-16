defmodule Bloc.Habits do
  @moduledoc """
  The Habits context.
  """

  import Ecto.Query, warn: false

  alias Bloc.Accounts.User
  alias Bloc.Habits.Habit
  alias Bloc.Repo
  alias Bloc.Tasks.Task
  alias Ecto.Changeset

  @doc """
  Returns the list of habits.

  ## Examples

      iex> list_habits()
      [%Habit{}, ...]

  """
  def list_habits(%User{id: user_id}, opts \\ []) do
    Habit
    |> QueryBuilder.where(user_id: user_id)
    |> QueryBuilder.from_list(opts)
    |> Repo.all()
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
  def create_habit(attrs \\ %{}) do
    Repo.transaction(fn _ ->
      with {:ok, habit} <- %Habit{} |> Habit.changeset(attrs) |> Repo.insert(),
           {:ok, _task} <- habit |> task_for_habit_today() |> maybe_insert_task() do
        habit
      else
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)
  end

  defp maybe_insert_task(%Changeset{} = task) do
    Repo.insert(task)
  end

  defp maybe_insert_task(nil), do: {:ok, nil}

  @spec task_for_habit_today(Habit.t()) :: Task.t()
  def task_for_habit_today(%Habit{} = habit) do
    today = Date.utc_today()

    blocks =
      if habit.start_time && habit.end_time do
        [
          %{
            title: habit.title,
            user_id: habit.user_id,
            start_time: DateTime.new!(today, habit.start_time),
            end_time: DateTime.new!(today, habit.end_time)
          }
        ]
      else
        []
      end

    Task.changeset(%Task{}, %{
      title: habit.title,
      habit_id: habit.id,
      user_id: habit.user_id,
      due_date: today,
      blocks: blocks
    })
  end

  def task_for_habit_today(_), do: {:ok, nil}

  @doc """
  Updates a habit.

  ## Examples

      iex> update_habit(habit, %{field: new_value})
      {:ok, %Habit{}}

      iex> update_habit(habit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_habit(%Habit{} = habit, attrs) do
    habit
    |> Habit.update_changeset(attrs)
    |> Repo.update()
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
end
