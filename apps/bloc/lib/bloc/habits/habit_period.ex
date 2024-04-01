defmodule Bloc.Habits.HabitPeriod do
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:habit, :user]

  alias Bloc.Accounts.User
  alias Bloc.Habits.Habit

  import Ecto.Changeset

  schema "habit_periods" do
    field :unit, Ecto.Enum, values: [:count, :hr, :min]
    field :value, :integer
    field :date, :date
    field :period_type, Ecto.Enum, values: [:daily, :weekly, :monthly]
    field :goal, :integer
    field :complete?, :utc_datetime
    field :active?, :utc_datetime
    field :deleted?, :utc_datetime

    belongs_to :habit, Habit
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(habit_period, attrs) do
    habit_period
    |> cast(attrs, [
      :period_type,
      :value,
      :goal,
      :complete?,
      :active?,
      :deleted?,
      :unit,
      :date,
      :user_id
    ])
    |> validate_required([
      :period_type,
      :value,
      :goal,
      :complete?,
      :active?,
      :deleted?,
      :unit,
      :date,
      :user_id
    ])
  end
end
