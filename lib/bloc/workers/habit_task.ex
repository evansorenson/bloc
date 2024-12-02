defmodule Bloc.Workers.HabitTask do
  @moduledoc false
  use Oban.Worker

  import Ecto.Query

  alias Bloc.Habits
  alias Bloc.Habits.Habit
  alias Bloc.Repo
  alias Bloc.Scope
  require Logger

  @impl true
  def perform(%Oban.Job{args: _args}) do
    today = Date.utc_today()
    day_of_week = Date.day_of_week(today)

    tasks =
      from(h in Habit,
        where: h.period_type == :daily,
        where: fragment("? = ANY(?)", ^day_of_week, h.days)
      )
      |> Repo.all()
      # todo pass scope from user in query
      |> Enum.map(&Habits.task_for_habit_day(&1, today, %Scope{}))
      |> Enum.map(&Repo.insert!/1)


    Logger.info("Inserted #{length(tasks)} tasks")

    :ok
  end
end
