defmodule Bloc.Workers.HabitTask do
  use Oban.Worker

  alias Bloc.Blocks.Block
  alias Bloc.Habits.Habit
  alias Bloc.Repo
  alias Bloc.Tasks.Task

  import Ecto.Query

  @impl true
  def perform(%Oban.Job{args: _args}) do
    from(h in Habit, where: h.period_type == :daily)
    |> Repo.all()
    |> Enum.map(&create_task/1)
    |> Repo.insert_all(on_conflict: :nothing, conflict_target: [:habit_id, :due_date])
  end

  defp create_task(%Habit{} = habit) do
    today = Date.utc_today()

    blocks =
      if habit.start_time && habit.end_time do
        [
          %Block{
            title: habit.title,
            user_id: habit.user_id,
            start_time: DateTime.new!(today, habit.start_time),
            end_time: DateTime.new!(today, habit.end_time)
          }
        ]
      else
        []
      end

    %Task{
      title: habit.title,
      habit_id: habit.id,
      user_id: habit.user_id,
      due_date: today,
      blocks: blocks
    }
  end
end
