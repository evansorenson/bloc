defmodule Bloc.Habits.Habit do
  use Bloc.Schema
  import Ecto.Changeset

  schema "habits" do
    field :unit, Ecto.Enum, values: [:count, :hr, :min]
    field :title, :string
    field :notes, :string
    field :period_type, Ecto.Enum, values: [:daily, :weekly, :monthly]
    field :goal, :integer
    field :user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:title, :notes, :period_type, :goal, :unit])
    |> validate_required([:title, :notes, :period_type, :goal, :unit])
  end
end
