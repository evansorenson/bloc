defmodule Bloc.Habits do
  @moduledoc """
  The Habits context.
  """

  import Ecto.Query, warn: false
  alias Bloc.Repo

  alias Bloc.Habits.Habit

  @doc """
  Returns the list of habits.

  ## Examples

      iex> list_habits()
      [%Habit{}, ...]

  """
  def list_habits do
    Repo.all(Habit)
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
    %Habit{}
    |> Habit.changeset(attrs)
    |> Repo.insert()
  end

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
    |> Habit.changeset(attrs)
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
  def change_habit(%Habit{} = habit, attrs \\ %{}) do
    Habit.changeset(habit, attrs)
  end

  alias Bloc.Habits.HabitPeriod

  @doc """
  Returns the list of habit_periods.

  ## Examples

      iex> list_habit_periods()
      [%HabitPeriod{}, ...]

  """
  def list_habit_periods do
    Repo.all(HabitPeriod)
  end

  @doc """
  Gets a single habit_period.

  Raises `Ecto.NoResultsError` if the Habit period does not exist.

  ## Examples

      iex> get_habit_period!(123)
      %HabitPeriod{}

      iex> get_habit_period!(456)
      ** (Ecto.NoResultsError)

  """
  def get_habit_period!(id), do: Repo.get!(HabitPeriod, id)

  @doc """
  Creates a habit_period.

  ## Examples

      iex> create_habit_period(%{field: value})
      {:ok, %HabitPeriod{}}

      iex> create_habit_period(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_habit_period(attrs \\ %{}) do
    %HabitPeriod{}
    |> HabitPeriod.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a habit_period.

  ## Examples

      iex> update_habit_period(habit_period, %{field: new_value})
      {:ok, %HabitPeriod{}}

      iex> update_habit_period(habit_period, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_habit_period(%HabitPeriod{} = habit_period, attrs) do
    habit_period
    |> HabitPeriod.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a habit_period.

  ## Examples

      iex> delete_habit_period(habit_period)
      {:ok, %HabitPeriod{}}

      iex> delete_habit_period(habit_period)
      {:error, %Ecto.Changeset{}}

  """
  def delete_habit_period(%HabitPeriod{} = habit_period) do
    Repo.delete(habit_period)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking habit_period changes.

  ## Examples

      iex> change_habit_period(habit_period)
      %Ecto.Changeset{data: %HabitPeriod{}}

  """
  def change_habit_period(%HabitPeriod{} = habit_period, attrs \\ %{}) do
    HabitPeriod.changeset(habit_period, attrs)
  end
end
