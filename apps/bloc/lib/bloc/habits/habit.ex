defmodule Bloc.Habits.Habit do
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:user, :habit_tasks]

  alias Bloc.Tasks.Task

  import Ecto.Changeset

  schema "habits" do
    field :title, :string
    field :notes, :string
    field :period_type, Ecto.Enum, values: [:daily, :weekly, :monthly]
    field :deleted?, :utc_datetime, default: nil

    has_many :habit_tasks, Task
    belongs_to :user, Bloc.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @create_required_fields ~w(title period_type user_id)a
  @optional_fields ~w(notes)a
  @all_fields @create_required_fields ++ @optional_fields

  @update_allowed ~w(title notes period_type deleted?)a

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, @all_fields)
    |> validate_required(@create_required_fields)
    |> add_current_task()
  end

  defp add_current_task(changeset) do
    put_assoc(changeset, :habit_tasks, [
      %Task{
        title: get_field(changeset, :title),
        notes: get_field(changeset, :notes),
        due_date: Date.utc_today(),
        user_id: get_field(changeset, :user_id)
      }
    ])
  end

  def update_changeset(changeset, attrs) do
    changeset
    |> cast(attrs, @update_allowed)
  end
end
