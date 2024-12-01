defmodule Bloc.Habits.HabitDay do
  @moduledoc false
  use Bloc.Schema

  import Ecto.Changeset

  schema "habit_days" do
    field :date, :date
    field :completed_count, :integer, default: 0
    field :completed?, :boolean, default: false

    belongs_to :habit, Bloc.Habits.Habit
    belongs_to :user, Bloc.Accounts.User

    timestamps(type: :utc_datetime)
  end

  def changeset(habit_day, attrs) do
    habit_day
    |> cast(attrs, [:date, :completed_count, :completed?, :habit_id, :user_id])
    |> validate_required([:date, :habit_id, :user_id])
    |> unique_constraint([:habit_id, :date])
  end
end
