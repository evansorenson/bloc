defmodule Bloc.Workers.HabitTask do
  @moduledoc false
  use Oban.Worker

  import Ecto.Query

  alias Bloc.Habits
  alias Bloc.Habits.Habit
  alias Bloc.Repo

  require Logger

  @impl true
  def perform(%Oban.Job{args: _args}) do
    tasks =
      from(h in Habit, where: h.period_type == :daily)
      |> Repo.all()
      |> Enum.map(&Habits.task_for_habit_today/1)
      |> Enum.map(&Repo.insert!/1)

    Logger.info("Inserted #{length(tasks)} tasks")

    :ok
  end
end
