defmodule Bloc.HabitsTest do
  use Bloc.DataCase

  alias Bloc.Habits

  setup [:user, :habit, :task]

  describe "habits" do
    alias Bloc.Habits.Habit

    @invalid_attrs %{title: nil, notes: nil, period_type: nil}

    test "list_habits/0 returns all habits", %{habit: habit, user: user} do
      assert Habits.list_habits(user) |> load_habit() == [habit]
    end

    test "get_habit!/1 returns the habit with given id", %{habit: habit} do
      assert Habits.get_habit!(habit.id) |> load_habit() == habit
    end

    test "create_habit/1 with valid data creates a habit", %{user: user} do
      valid_attrs = %{
        title: "some title",
        notes: "some notes",
        period_type: :daily,
        user_id: user.id
      }

      assert {:ok, %Habit{} = habit} = Habits.create_habit(valid_attrs)
      assert habit.title == "some title"
      assert habit.notes == "some notes"
      assert habit.period_type == :daily
    end

    test "create_habit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Habits.create_habit(@invalid_attrs)
    end

    test "update_habit/2 with valid data updates the habit", %{habit: habit} do
      update_attrs = %{
        title: "some updated title",
        notes: "some updated notes",
        period_type: :weekly
      }

      assert {:ok, %Habit{} = habit} = Habits.update_habit(habit, update_attrs)
      assert habit.title == "some updated title"
      assert habit.notes == "some updated notes"
      assert habit.period_type == :weekly
    end

    test "change_habit/1 returns a habit changeset" do
      assert %Ecto.Changeset{} = Habits.change_create_habit(@invalid_attrs)
    end
  end

  defp load_habit(habits) when is_list(habits) do
    habits |> Enum.map(&load_habit/1)
  end

  defp load_habit(habit) do
    habit |> Repo.preload([:user], force: true)
  end
end
