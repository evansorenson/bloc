defmodule Bloc.HabitsTest do
  use Bloc.DataCase

  alias Bloc.Habits

  describe "habits" do
    alias Bloc.Habits.Habit

    import Bloc.HabitsFixtures

    @invalid_attrs %{unit: nil, title: nil, notes: nil, period_type: nil, goal: nil}

    test "list_habits/0 returns all habits" do
      habit = habit_fixture()
      assert Habits.list_habits() == [habit]
    end

    test "get_habit!/1 returns the habit with given id" do
      habit = habit_fixture()
      assert Habits.get_habit!(habit.id) == habit
    end

    test "create_habit/1 with valid data creates a habit" do
      valid_attrs = %{
        unit: :count,
        title: "some title",
        notes: "some notes",
        period_type: :daily,
        goal: 42
      }

      assert {:ok, %Habit{} = habit} = Habits.create_habit(valid_attrs)
      assert habit.unit == :count
      assert habit.title == "some title"
      assert habit.notes == "some notes"
      assert habit.period_type == :daily
      assert habit.goal == 42
    end

    test "create_habit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Habits.create_habit(@invalid_attrs)
    end

    test "update_habit/2 with valid data updates the habit" do
      habit = habit_fixture()

      update_attrs = %{
        unit: :hr,
        title: "some updated title",
        notes: "some updated notes",
        period_type: :weekly,
        goal: 43
      }

      assert {:ok, %Habit{} = habit} = Habits.update_habit(habit, update_attrs)
      assert habit.unit == :hr
      assert habit.title == "some updated title"
      assert habit.notes == "some updated notes"
      assert habit.period_type == :weekly
      assert habit.goal == 43
    end

    test "update_habit/2 with invalid data returns error changeset" do
      habit = habit_fixture()
      assert {:error, %Ecto.Changeset{}} = Habits.update_habit(habit, @invalid_attrs)
      assert habit == Habits.get_habit!(habit.id)
    end

    test "delete_habit/1 deletes the habit" do
      habit = habit_fixture()
      assert {:ok, %Habit{}} = Habits.delete_habit(habit)
      assert_raise Ecto.NoResultsError, fn -> Habits.get_habit!(habit.id) end
    end

    test "change_habit/1 returns a habit changeset" do
      habit = habit_fixture()
      assert %Ecto.Changeset{} = Habits.change_habit(habit)
    end
  end

  describe "habit_periods" do
    alias Bloc.Habits.HabitPeriod

    import Bloc.HabitsFixtures

    @invalid_attrs %{
      unit: nil,
      value: nil,
      date: nil,
      period_type: nil,
      goal: nil,
      complete?: nil,
      active?: nil
    }

    test "list_habit_periods/0 returns all habit_periods" do
      habit_period = habit_period_fixture()
      assert Habits.list_habit_periods() == [habit_period]
    end

    test "get_habit_period!/1 returns the habit_period with given id" do
      habit_period = habit_period_fixture()
      assert Habits.get_habit_period!(habit_period.id) == habit_period
    end

    test "create_habit_period/1 with valid data creates a habit_period" do
      valid_attrs = %{
        unit: :count,
        value: 42,
        date: ~D[2024-03-29],
        period_type: :daily,
        goal: 42,
        complete?: ~N[2024-03-29 16:31:00],
        active?: ~N[2024-03-29 16:31:00]
      }

      assert {:ok, %HabitPeriod{} = habit_period} = Habits.create_habit_period(valid_attrs)
      assert habit_period.unit == :count
      assert habit_period.value == 42
      assert habit_period.date == ~D[2024-03-29]
      assert habit_period.period_type == :daily
      assert habit_period.goal == 42
      assert habit_period.complete? == ~N[2024-03-29 16:31:00]
      assert habit_period.active? == ~N[2024-03-29 16:31:00]
    end

    test "create_habit_period/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Habits.create_habit_period(@invalid_attrs)
    end

    test "update_habit_period/2 with valid data updates the habit_period" do
      habit_period = habit_period_fixture()

      update_attrs = %{
        unit: :hr,
        value: 43,
        date: ~D[2024-03-30],
        period_type: :weekly,
        goal: 43,
        complete?: ~N[2024-03-30 16:31:00],
        active?: ~N[2024-03-30 16:31:00]
      }

      assert {:ok, %HabitPeriod{} = habit_period} =
               Habits.update_habit_period(habit_period, update_attrs)

      assert habit_period.unit == :hr
      assert habit_period.value == 43
      assert habit_period.date == ~D[2024-03-30]
      assert habit_period.period_type == :weekly
      assert habit_period.goal == 43
      assert habit_period.complete? == ~N[2024-03-30 16:31:00]
      assert habit_period.active? == ~N[2024-03-30 16:31:00]
    end

    test "update_habit_period/2 with invalid data returns error changeset" do
      habit_period = habit_period_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Habits.update_habit_period(habit_period, @invalid_attrs)

      assert habit_period == Habits.get_habit_period!(habit_period.id)
    end

    test "delete_habit_period/1 deletes the habit_period" do
      habit_period = habit_period_fixture()
      assert {:ok, %HabitPeriod{}} = Habits.delete_habit_period(habit_period)
      assert_raise Ecto.NoResultsError, fn -> Habits.get_habit_period!(habit_period.id) end
    end

    test "change_habit_period/1 returns a habit_period changeset" do
      habit_period = habit_period_fixture()
      assert %Ecto.Changeset{} = Habits.change_habit_period(habit_period)
    end
  end
end
