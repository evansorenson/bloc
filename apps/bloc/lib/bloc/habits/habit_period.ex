defmodule Bloc.Habits.HabitPeriod do
  use Bloc.Schema
  import Ecto.Changeset

  schema "habit_periods" do
    field :unit, Ecto.Enum, values: [:count, :hr, :min]
    field :value, :integer
    field :date, :date
    field :period_type, Ecto.Enum, values: [:daily, :weekly, :monthly]
    field :goal, :integer
    field :is_complete, :naive_datetime
    field :is_active, :naive_datetime
    field :habit_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(habit_period, attrs) do
    habit_period
    |> cast(attrs, [:period_type, :value, :goal, :is_complete, :is_active, :unit, :date])
    |> validate_required([:period_type, :value, :goal, :is_complete, :is_active, :unit, :date])
  end
end
