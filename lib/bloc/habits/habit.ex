defmodule Bloc.Habits.Habit do
  @moduledoc false
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:user, :tasks, :parent, :subhabits]

  import Ecto.Changeset

  alias Bloc.Tasks.Task
  alias Ecto.Changeset

  schema "habits" do
    field :title, :string
    field :notes, :string
    field :period_type, Ecto.Enum, values: [:daily, :monthly]
    field :deleted?, :utc_datetime, default: nil
    field :start_time, :time
    field :end_time, :time
    field :streak, :integer, default: 0
    field :required_count, :integer, default: 1
    field :days, {:array, :integer}, default: [1, 2, 3, 4, 5, 6, 7]

    belongs_to :parent, __MODULE__, foreign_key: :parent_id

    has_many :subhabits, __MODULE__,
      foreign_key: :parent_id,
      where: [deleted?: nil]

    has_many :habit_days, Bloc.Habits.HabitDay

    has_many :tasks, Task, on_delete: :delete_all
    belongs_to :user, Bloc.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @create_required_fields ~w(title period_type user_id)a
  @optional_fields ~w(notes start_time end_time required_count days parent_id)a
  @all_fields @create_required_fields ++ @optional_fields

  @update_allowed ~w(title notes period_type deleted? streak required_count days)a

  @doc false
  def changeset(habit \\ %__MODULE__{}, attrs) do
    habit
    |> cast(attrs, @all_fields)
    |> validate_required(@create_required_fields)
    |> require_both_start_and_end_time()
    |> validate_start_time()
  end

  def update_changeset(changeset, attrs) do
    changeset
    |> cast(attrs, @update_allowed)
    |> require_both_start_and_end_time()
    |> validate_start_time()
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

    if !start_time || Time.before?(start_time, end_time) do
      changeset
    else
      add_error(changeset, :start_time, "must be before end time")
    end
  end

  defp validate_start_time(changeset), do: changeset
end
