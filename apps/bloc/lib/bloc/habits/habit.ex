defmodule Bloc.Habits.Habit do
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:user, :tasks]

  alias Bloc.Tasks.Task
  alias Ecto.Changeset

  import Ecto.Changeset

  schema "habits" do
    field :title, :string
    field :notes, :string
    field :period_type, Ecto.Enum, values: [:daily, :weekly, :monthly]
    field :deleted?, :utc_datetime, default: nil
    field :start_time, :time
    field :end_time, :time

    has_many :tasks, Task
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
    |> require_both_start_and_end_time()
    |> validate_start_time()
  end

  def update_changeset(changeset, attrs) do
    changeset
    |> cast(attrs, @update_allowed)
  end

  def require_both_start_and_end_time(changeset) do
    start_time = get_field(changeset, :start_time)
    end_time = get_field(changeset, :end_time)

    case {start_time, end_time} do
      {nil, end_time} when not is_nil(end_time) ->
        add_error(changeset, :start_time, "must be present when end time is given")

      {start_time, nil} when not is_nil(start_time) ->
        add_error(changeset, :end_time, "must be present when start time is given")

      _ ->
        changeset
    end
  end

  defp validate_start_time(%Changeset{valid?: true} = changeset) do
    start_time = get_field(changeset, :start_time)
    end_time = get_field(changeset, :end_time)

    if DateTime.before?(start_time, end_time) do
      changeset
    else
      add_error(changeset, :start_time, "must be before end time")
    end
  end

  defp validate_start_time(changeset), do: changeset
end
