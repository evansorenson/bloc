defmodule Bloc.Tasks do
  @moduledoc """
  The Tasks context.

  This module handles all task and task list related operations. All operations require
  a scope containing the current user's ID for authorization.
  """

  import Ecto.Query

  alias Bloc.Events.TaskCompleted
  alias Bloc.Events.TaskCreated
  alias Bloc.Events.TaskDeleted
  # TaskMoved,
  alias Bloc.Events.TaskListCreated
  alias Bloc.Events.TaskListDeleted
  alias Bloc.Events.TaskListUpdated
  alias Bloc.Events.TaskUpdated
  alias Bloc.Habits
  alias Bloc.Query
  alias Bloc.Repo
  alias Bloc.Rewards
  alias Bloc.Scope
  alias Bloc.Tasks.Task
  alias Bloc.Tasks.TaskList
  alias Jirex.IssueSearch

  @pubsub Bloc.PubSub

  def subscribe(scope) do
    Phoenix.PubSub.subscribe(@pubsub, topic(scope))
  end

  defp topic(scope), do: "tasks:#{scope.current_user_id}"

  @doc """
  Returns the list of tasks for the given scope.

  ## Parameters

    * scope - A `Bloc.Scope` struct containing the current user's ID
    * opts - Optional list of query options

  ## Examples

      iex> list_tasks(%Scope{current_user_id: user.id})
      [%Task{}, ...]

      iex> list_tasks(%Scope{current_user_id: user.id}, where: [complete?: true])
      [%Task{complete?: ~U[2024-03-25 17:34:00Z]}, ...]

  """
  def list_tasks(%Scope{current_user_id: user_id}, opts \\ []) do
    defaults = [deleted?: false, completed?: false, preload: [:habit, :subtasks]]
    opts = Keyword.merge(defaults, opts)

    from(t in Task)
    |> Query.for_user(user_id)
    |> deleted(opts[:deleted?])
    |> completed(opts[:completed?])
    |> between_dates(opts[:between_dates])
    |> filter_by_date(opts[:date])
    |> filter_by_task_list_id(opts[:task_list_id])
    |> filter_by_habit_id(opts[:habit_id])
    |> Query.preloads(opts[:preload])
    |> Repo.all()
  end

  defp filter_by_task_list_id(query, nil), do: query

  defp filter_by_task_list_id(query, :none) do
    where(query, [q], is_nil(q.task_list_id))
  end

  defp filter_by_task_list_id(query, task_list_id) when is_binary(task_list_id) do
    where(query, [q], q.task_list_id == ^task_list_id)
  end

  defp filter_by_task_list_id(query, task_list_ids) when is_list(task_list_ids) do
    where(query, [q], q.task_list_id in ^task_list_ids)
  end

  defp filter_by_habit_id(query, nil), do: query

  defp filter_by_habit_id(query, :none) do
    where(query, [q], is_nil(q.habit_id))
  end

  defp filter_by_habit_id(query, habit_id) when is_binary(habit_id) do
    where(query, [q], q.habit_id == ^habit_id)
  end

  defp filter_by_habit_id(query, habit_ids) when is_list(habit_ids) do
    where(query, [q], q.habit_id in ^habit_ids)
  end

  @spec list_for_integration(Scope.t(), atom) :: {:ok, list()} | {:error, any()}
  def list_for_integration(%Scope{current_user_id: _user_id}, :jira) do
    [
      jql: "assignee=currentUser() AND sprint in openSprints() AND status != 'Closed' ORDER BY created DESC",
      fields: "summary,status",
      maxResults: 10
    ]
    |> IssueSearch.search_for_issues_using_jql()
    |> case do
      {:ok, response} ->
        {:ok, response.body.issues}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the task does not exist or does not belong to the user.

  ## Parameters

    * id - The ID of the task to fetch
    * scope - A `Bloc.Scope` struct containing the current user's ID

  ## Examples

      iex> get_task!(123, %Scope{current_user_id: user.id})
      %Task{}

      iex> get_task!(456, %Scope{current_user_id: user.id})
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Task |> Repo.get!(id) |> Repo.preload(:subtasks)

  @doc """
  Creates a task.

  ## Parameters

    * attrs - Map of attributes for the new task
    * scope - A `Bloc.Scope` struct containing the current user's ID

  ## Examples

      iex> create_task(%{title: "Do something"}, %Scope{current_user_id: user.id})
      {:ok, %Task{}}

      iex> create_task(%{title: nil}, %Scope{current_user_id: user.id})
      {:error, %Ecto.Changeset{}}

  ## Events

  Broadcasts a `%TaskCreated{}` event on success.
  """
  def create_task(attrs, scope) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, task} ->
        broadcast_event(scope, %TaskCreated{task: task})
        {:ok, task}

      error ->
        error
    end
  end

  @doc """
  Creates a task for a habit.

  ## Examples

      iex> create_habit_task(%{field: value})
      {:ok, %Task{}}

      iex> create_habit_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_habit_task(attrs \\ %{}, scope) do
    %Task{}
    |> Task.habit_changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, task} ->
        broadcast_event(scope, %TaskCreated{task: task})
        {:ok, task}

      error ->
        error
    end
  end

  @doc """
  Updates a task.

  ## Parameters

    * task - The task to update
    * attrs - Map of attributes to update
    * scope - A `Bloc.Scope` struct containing the current user's ID

  ## Examples

      iex> update_task(task, %{title: "New title"}, %Scope{current_user_id: user.id})
      {:ok, %Task{}}

      iex> update_task(task, %{title: nil}, %Scope{current_user_id: user.id})
      {:error, %Ecto.Changeset{}}

  ## Events

  Broadcasts a `%TaskUpdated{}` event on success.
  """
  def update_task(%Task{} = task, attrs, scope) do
    task
    |> Task.update_changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, updated_task} ->
        broadcast_event(scope, %TaskUpdated{task: updated_task, old_task: task})
        {:ok, task}

      error ->
        error
    end
  end

  @doc """
  Set task to complete
  """
  @spec toggle_complete(task :: %Task{}, complete? :: boolean(), scope :: %Scope{}) ::
          {:ok, %Task{}} | {:error, %Ecto.Changeset{}}
  def toggle_complete(task, complete?, %Scope{} = scope) do
    complete_timestamp = if complete?, do: DateTime.utc_now()

    Repo.transaction(fn ->
      with {:ok, task} <- task |> Task.update_changeset(%{complete?: complete_timestamp}) |> Repo.update(),
           {:ok, _habit_day} <-
             Habits.increment_habit_day_and_calculate_streak(task.habit, scope, task.due_date, decrement?: not complete?),
           {:ok, reward} <- (if complete?, do: Rewards.select_random_reward(scope), else: {:ok, nil}),
           {:ok, _reward_history} <- Rewards.create_reward_history(reward, task, scope) do
        broadcast_event(scope, %TaskCompleted{task: task, reward: reward})
        task
      else
        error ->
          Repo.rollback(error)
      end
    end)
  end

  @doc """
  Deletes a task.

  ## Parameters

    * task - The task to delete
    * scope - A `Bloc.Scope` struct containing the current user's ID

  ## Examples

      iex> delete_task(task, %Scope{current_user_id: user.id})
      {:ok, %Task{}}

      iex> delete_task(task, %Scope{current_user_id: other_user.id})
      {:error, :unauthorized}

  ## Events

  Broadcasts a `%TaskDeleted{}` event on success.
  """
  def delete_task(%Task{} = task, %Scope{} = scope) do
    task
    |> Repo.delete()
    |> case do
      {:ok, task} ->
        broadcast_event(scope, %TaskDeleted{task: task})
        {:ok, task}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  @doc """
  Returns the list of task_lists.

  ## Examples

      iex> list_task_lists()
      [%TaskList{}, ...]

  """
  def list_task_lists(%Scope{current_user_id: user_id}, _opts \\ []) do
    TaskList
    |> Query.for_user(user_id)
    |> Query.order_by_position()
    |> Query.preloads(tasks: [:subtasks, :habit])
    |> Repo.all()
  end

  @doc """
  Gets a single task_list.

  Raises `Ecto.NoResultsError` if the Task list does not exist.

  ## Examples

      iex> get_task_list!(123)
      %TaskList{}

      iex> get_task_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task_list!(id, %Scope{current_user_id: user_id}) do
    TaskList
    |> Query.for_user(user_id)
    |> Repo.get!(id)
  end

  @doc """
  Creates a task_list.

  ## Examples

      iex> create_task_list(%{field: value})
      {:ok, %TaskList{}}

      iex> create_task_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task_list(attrs \\ %{}, %Scope{} = scope) do
    attrs = Map.put(attrs, "user_id", scope.current_user_id)

    %TaskList{}
    |> TaskList.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, task_list} ->
        broadcast_event(scope, %TaskListCreated{task_list: task_list})
        {:ok, task_list}

      error ->
        error
    end
  end

  @doc """
  Updates a task_list.

  ## Examples

      iex> update_task_list(task_list, %{field: new_value})
      {:ok, %TaskList{}}

      iex> update_task_list(task_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task_list(%TaskList{} = task_list, attrs, %Scope{} = scope) do
    task_list
    |> TaskList.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, task_list} ->
        broadcast_event(scope, %TaskListUpdated{task_list: task_list})
        {:ok, task_list}

      error ->
        error
    end
  end

  @doc """
  Deletes a task_list.

  ## Examples

      iex> delete_task_list(task_list)
      {:ok, %TaskList{}}

      iex> delete_task_list(task_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task_list(%TaskList{} = task_list, %Scope{} = scope) do
    task_list
    |> Repo.delete()
    |> case do
      {:ok, task_list} ->
        broadcast_event(scope, %TaskListDeleted{task_list: task_list})
        {:ok, task_list}

      error ->
        error
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task_list changes.

  ## Examples

      iex> change_task_list(task_list)
      %Ecto.Changeset{data: %TaskList{}}

  """
  def change_task_list(%TaskList{} = task_list, attrs \\ %{}) do
    TaskList.changeset(task_list, attrs)
  end

  defp broadcast_event(scope, event) when is_struct(event) do
    Phoenix.PubSub.broadcast(@pubsub, topic(scope), {__MODULE__, event})
  end

  defp filter_by_date(query, nil), do: query

  defp filter_by_date(query, date) do
    where(query, [t], t.due_date == ^date)
  end

  defp between_dates(query, nil), do: query

  defp between_dates(query, {%Date{} = start_date, %Date{} = end_date}) do
    query
    |> where([q], q.due_date >= ^start_date)
    |> where([q], q.due_date <= ^end_date)
  end

  defp deleted(query, true) do
    where(query, [q], not is_nil(q.deleted?))
  end

  defp deleted(query, _deleted) do
    where(query, [q], is_nil(q.deleted?))
  end

  defp completed(query, true) do
    where(query, [q], not is_nil(q.complete?))
  end

  defp completed(query, _completed) do
    where(query, [q], is_nil(q.complete?))
  end
end
