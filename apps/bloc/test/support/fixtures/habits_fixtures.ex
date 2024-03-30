defmodule Bloc.HabitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bloc.Habits` context.
  """

  @doc """
  Generate a habit.
  """
  def habit_fixture(attrs \\ %{}) do
    {:ok, habit} =
      attrs
      |> Enum.into(%{
        goal: 42,
        notes: "some notes",
        period_type: :daily,
        title: "some title",
        unit: :count
      })
      |> Bloc.Habits.create_habit()

    habit
  end

  @doc """
  Generate a habit_period.
  """
  def habit_period_fixture(attrs \\ %{}) do
    {:ok, habit_period} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-03-29],
        goal: 42,
        is_active: ~N[2024-03-29 16:31:00],
        is_complete: ~N[2024-03-29 16:31:00],
        period_type: :daily,
        unit: :count,
        value: 42
      })
      |> Bloc.Habits.create_habit_period()

    habit_period
  end
end
