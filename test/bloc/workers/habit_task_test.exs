defmodule Bloc.Workers.HabitTaskTest do
  use Bloc.DataCase

  alias Bloc.Tasks.Task
  alias Bloc.Workers.HabitTask

  doctest Bloc.Workers.HabitTask

  describe "perform/1" do
    test "task inserted for daily habits" do
      daily_habit = insert(:habit, period_type: :daily)
      _weekly_habit = insert(:habit, period_type: :weekly)
      _monthly_habit = insert(:habit, period_type: :monthly)

      HabitTask.perform(%Oban.Job{args: nil})

      [task] = Repo.all(Task)
      assert task.habit_id == daily_habit.id
      assert task.due_date == Date.utc_today()
      assert task.title == daily_habit.title
      assert task.user_id == daily_habit.user_id
    end

    test "inserts block if habit has start and end time" do
      habit =
        insert(:habit,
          period_type: :daily,
          start_time: ~T[09:00:00],
          end_time: ~T[10:00:00]
        )

      HabitTask.perform(%Oban.Job{args: nil})

      [task] = Task |> Repo.all() |> Repo.preload(:blocks)
      [block] = task.blocks
      assert block.title == habit.title
      assert block.start_time == DateTime.new!(Date.utc_today(), ~T[09:00:00])
      assert block.end_time == DateTime.new!(Date.utc_today(), ~T[10:00:00])
    end
  end
end
