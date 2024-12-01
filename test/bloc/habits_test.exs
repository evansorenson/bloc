defmodule Bloc.HabitsTest do
  use Bloc.DataCase

  alias Bloc.Habits

  setup [:user, :habit, :task_list, :task]

  describe "habits" do
    alias Bloc.Habits.Habit

    @invalid_attrs %{title: nil, notes: nil, period_type: nil}

    test "list_habits/0 returns all habits", %{habit: habit, user: user} do
      assert user |> Habits.list_habits() |> load_habit() == [habit]
    end

    test "get_habit!/1 returns the habit with given id", %{habit: habit} do
      assert habit.id |> Habits.get_habit!() |> load_habit() == habit
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

    test "create_habit/1 cannot create with start_time after end_time", %{user: user} do
      invalid_attrs = %{
        title: "some title",
        notes: "some notes",
        period_type: :daily,
        user_id: user.id,
        start_time: ~T[12:00:00],
        end_time: ~T[10:00:00]
      }

      assert {:error, %Ecto.Changeset{errors: [start_time: {"must be before end time", []}]}} =
               Habits.create_habit(invalid_attrs)
    end

    test "create_habit/1 cannot create with start_time and no end_time", %{user: user} do
      invalid_attrs = %{
        title: "some title",
        notes: "some notes",
        period_type: :daily,
        user_id: user.id,
        start_time: ~T[09:00:00]
      }

      assert {:error,
              %Ecto.Changeset{
                errors: [end_time: {"must be present when start time is given", []}]
              }} = Habits.create_habit(invalid_attrs)
    end

    test "create_habit/1 with valid data creates a habit with start and end time", %{user: user} do
      valid_attrs = %{
        title: "some title",
        notes: "some notes",
        period_type: :daily,
        user_id: user.id,
        start_time: ~T[09:00:00],
        end_time: ~T[10:00:00]
      }

      assert {:ok, %Habit{} = habit} = Habits.create_habit(valid_attrs)
      assert habit.title == "some title"
      assert habit.notes == "some notes"
      assert habit.period_type == :daily
      assert habit.start_time == ~T[09:00:00]
      assert habit.end_time == ~T[10:00:00]
    end

    test "create_habit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Habits.create_habit(@invalid_attrs)
    end

    test "create_habit/1 with valid data creates tasks for the habit", %{user: user} do
      valid_attrs = %{
        title: "some title",
        notes: "some notes",
        period_type: :daily,
        user_id: user.id
      }

      assert {:ok, habit} = Habits.create_habit(valid_attrs)
      assert user |> Bloc.Scope.for_user() |> Bloc.Tasks.list_tasks(habit_id: habit.id) |> length() == 366
      assert Bloc.Blocks.Block |> Repo.all() |> length() == 0
    end

    test "create_habit/1 with valid data creates blocks for the habit", %{user: user} do
      valid_attrs = %{
        title: "some title",
        notes: "some notes",
        period_type: :daily,
        user_id: user.id,
        start_time: ~T[09:00:00],
        end_time: ~T[10:00:00]
      }

      assert {:ok, _} = Habits.create_habit(valid_attrs)
      assert Bloc.Blocks.Block |> Repo.all() |> length() == 366
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

  describe "calculate_streak/1" do
    test "calculates streak with completed habit days", %{habit: habit, user: user} do
      today = user |> Bloc.Scope.for_user() |> TimeUtils.today()
      yesterday = Date.add(today, -1)
      two_days_ago = Date.add(today, -2)

      # Create completed habit days for the last 3 days
      insert(:habit_day,
        habit: habit,
        user: user,
        date: two_days_ago,
        completed?: true
      )

      insert(:habit_day,
        habit: habit,
        user: user,
        date: yesterday,
        completed?: true
      )

      insert(:habit_day,
        habit: habit,
        user: user,
        date: today,
        completed?: true
      )

      assert {:ok, updated_habit} = Habits.calculate_streak(habit)
      assert updated_habit.streak == 3
    end

    test "breaks streak on missed day", %{habit: habit, user: user} do
      today = user |> Bloc.Scope.for_user() |> TimeUtils.today()
      yesterday = Date.add(today, -1)
      three_days_ago = Date.add(today, -3)

      # Create completed habit days with a gap
      insert(:habit_day,
        habit: habit,
        user: user,
        date: three_days_ago,
        completed?: true
      )

      insert(:habit_day,
        habit: habit,
        user: user,
        date: yesterday,
        completed?: true
      )

      insert(:habit_day,
        habit: habit,
        user: user,
        date: today,
        completed?: true
      )

      assert {:ok, updated_habit} = Habits.calculate_streak(habit)
      assert updated_habit.streak == 2
    end

    test "counts today's completed habit day in streak", %{habit: habit, user: user} do
      today = user |> Bloc.Scope.for_user() |> TimeUtils.today()

      insert(:habit_day,
        habit: habit,
        user: user,
        date: today,
        completed?: true
      )

      assert {:ok, updated_habit} = Habits.calculate_streak(habit)
      assert updated_habit.streak == 1
    end

    test "doesn't count today's incomplete habit day in streak", %{habit: habit, user: user} do
      today = user |> Bloc.Scope.for_user() |> TimeUtils.today()

      insert(:habit_day,
        habit: habit,
        user: user,
        date: today,
        completed?: false
      )

      assert {:ok, updated_habit} = Habits.calculate_streak(habit)
      assert updated_habit.streak == 0
    end
  end

  defp load_habit(habits) when is_list(habits) do
    Enum.map(habits, &load_habit/1)
  end

  defp load_habit(habit) do
    Repo.preload(habit, [:user], force: true)
  end
end
