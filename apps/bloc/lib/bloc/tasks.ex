defmodule Bloc.Tasks do
  @moduledoc """
  The Tasks context.
  """

  alias Bloc.Repo
  alias Bloc.Scope
  alias Bloc.Tasks.Task
  alias Bloc.Tasks.TaskList
  alias Jirex.IssueSearch

  @pubsub Bloc.PubSub

  def subscribe(scope) do
    Phoenix.PubSub.subscribe(@pubsub, topic(scope))
  end

  def unsubscribe(scope) do
    Phoenix.PubSub.unsubscribe(@pubsub, topic(scope))
  end

  defp topic(%Scope{current_user_id: current_user_id}), do: "tasks:#{current_user_id}"

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks(%Scope{})
      [%Task{}, ...]

  """
  def list_tasks(%Scope{current_user_id: user_id}, opts \\ []) do
    Task
    |> QueryBuilder.where(user_id: user_id)
    |> QueryBuilder.where(parent_id: nil)
    |> QueryBuilder.where(complete?: nil)
    |> QueryBuilder.order_by(asc: :position)
    |> QueryBuilder.preload([:subtasks])
    |> QueryBuilder.from_list(opts)
    |> Repo.all()
  end

  @spec list_for_integration(Scope.t(), atom) :: {:ok, list()} | {:error, any()}
  def list_for_integration(%Scope{current_user_id: _user_id}, :jira) do
    # TODO: would have to find jira token/info by user here or assign in scope maybe ?
    # for now we can just use my token :)

    [
      jql: "assignee=currentUser()  AND status != 'Closed' order by createdDate DESC",
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

  Raises `Ecto.NoResultsError` if the Habit period does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Task |> Repo.get!(id) |> Repo.preload(:subtasks)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a task for a habit.

  ## Examples

      iex> create_habit_task(%{field: value})
      {:ok, %Task{}}

      iex> create_habit_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_habit_task(attrs \\ %{}) do
    %Task{}
    |> Task.habit_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Set task to complete
  """
  @spec toggle_complete(task :: %Task{}, complete? :: boolean()) :: {:ok, %Task{}}
  def toggle_complete(task, true) do
    update_task(task, %{complete?: DateTime.utc_now()})
  end

  def toggle_complete(task, false) do
    update_task(task, %{complete?: nil})
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
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
  def list_task_lists(%Scope{current_user_id: user_id}, opts \\ []) do
    TaskList
    |> QueryBuilder.where(user_id: user_id)
    |> QueryBuilder.order_by(asc: :position)
    |> QueryBuilder.preload([:tasks])
    |> QueryBuilder.from_list(opts)
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
  def get_task_list!(id), do: Repo.get!(TaskList, id)

  @doc """
  Creates a task_list.

  ## Examples

      iex> create_task_list(%{field: value})
      {:ok, %TaskList{}}

      iex> create_task_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task_list(attrs \\ %{}) do
    %TaskList{}
    |> TaskList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task_list.

  ## Examples

      iex> update_task_list(task_list, %{field: new_value})
      {:ok, %TaskList{}}

      iex> update_task_list(task_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task_list(%TaskList{} = task_list, attrs) do
    task_list
    |> TaskList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a task_list.

  ## Examples

      iex> delete_task_list(task_list)
      {:ok, %TaskList{}}

      iex> delete_task_list(task_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task_list(%TaskList{} = task_list) do
    Repo.delete(task_list)
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
end
