defmodule Bloc.Tasks do
  @moduledoc """
  The Tasks context.
  """

  alias Bloc.Accounts.User
  alias Bloc.Repo
  alias Bloc.Tasks.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks(%User{})
      [%Task{}, ...]

  """
  def list_tasks(%User{id: user_id}, opts \\ []) do
    QueryBuilder.where(Task, user_id: user_id)
    |> QueryBuilder.preload([:habit])
    |> QueryBuilder.from_list(opts)
    |> Repo.all()
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
  def get_task!(id), do: Repo.get!(Task, id)

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
end
