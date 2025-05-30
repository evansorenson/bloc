defmodule Bloc.Tasks.Task do
  @moduledoc false
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:task_list, :habit, :user, :parent, :subtasks]

  import Ecto.Changeset

  alias Bloc.Accounts.User
  alias Bloc.Blocks.Block
  alias Bloc.Habits.Habit
  alias Bloc.Tasks.TaskList

  @required_fields ~w(title user_id)a
  @optional_fields ~w(assigned_date due_date notes habit_id complete? active? deleted? task_list_id parent_id estimated_minutes)a

  @habit_required_fields ~w(habit_id user_id due_date)a

  @all_fields @required_fields ++ @optional_fields

  @update_allowed_fields ~w(due_date title notes complete? active? deleted?)a

  schema "tasks" do
    field :active?, :utc_datetime
    field :complete?, :utc_datetime
    field :deleted?, :utc_datetime
    field :assigned_date, :date
    field :due_date, :date
    field :notes, :string
    field :title, :string
    field :position, :integer
    field :estimated_minutes, :integer
    field :rolled_over_count, :integer

    belongs_to :parent, __MODULE__, foreign_key: :parent_id
    belongs_to :task_list, TaskList
    belongs_to :habit, Habit
    belongs_to :user, User

    has_many :subtasks, __MODULE__,
      foreign_key: :parent_id,
      preload_order: [asc: :position]

    has_many :blocks, Block

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, @all_fields)
    |> cast_assoc(:blocks)
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 1, max: 512)

    # |> require_task_list_or_parent()
  end

  def habit_changeset(task, attrs) do
    task
    |> cast(attrs, @all_fields)
    |> validate_required(@habit_required_fields)
  end

  def update_changeset(task, attrs) do
    task
    |> cast(attrs, @update_allowed_fields)
    |> validate_required(@required_fields)
  end

  # defp require_task_list_or_parent(changeset) do
  #   task_list_id = get_field(changeset, :task_list_id)
  #   parent_id = get_field(changeset, :parent_id)
  #   habit_id = get_field(changeset, :habit_id)

  #   if task_list_id || parent_id || habit_id do
  #     changeset
  #   else
  #     add_error(changeset, :task_list_id, "must belong to a task list, parent, or habit")
  #   end
  # end
end
