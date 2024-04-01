defmodule Bloc.Habits.Habit do
  use Bloc.Schema

  alias Bloc.Habits.HabitPeriod

  import Ecto.Changeset

  schema "habits" do
    field :unit, Ecto.Enum, values: [:count, :hr, :min]
    field :title, :string
    field :notes, :string
    field :period_type, Ecto.Enum, values: [:daily, :weekly, :monthly]
    field :goal, :integer
    field :user_id, :binary_id
    field :deleted?, :utc_datetime, default: nil

    has_many :habit_periods, HabitPeriod

    timestamps(type: :utc_datetime)
  end

  @create_required_fields ~w(title notes period_type goal unit user_id)a
  @update_allowed ~w(title notes period_type goal unit)a

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, @create_required_fields)
    |> validate_required(@create_required_fields)
    |> add_current_habit_period()
    |> IO.inspect()
  end

  defp add_current_habit_period(changeset) do
    put_assoc(changeset, :habit_periods, [
      %HabitPeriod{
        active?: DateTime.utc_now() |> DateTime.truncate(:second),
        period_type: get_field(changeset, :period_type),
        value: 0,
        goal: get_field(changeset, :goal),
        unit: get_field(changeset, :unit),
        # TODO: set date based on period type (monthly at beginning of month, weekly on Sunday, daily at current date)
        date: Date.utc_today(),
        user_id: get_field(changeset, :user_id)
      }
    ])
  end

  def update_changeset(changeset, attrs) do
    changeset
    |> cast(attrs, @update_allowed)
  end
end
