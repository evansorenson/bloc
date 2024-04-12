defmodule Bloc.Tasks.Task do
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:task_list, :habit, :user, :parent, :subtasks]

  alias Bloc.Tasks.TaskList
  alias Bloc.Accounts.User
  alias Bloc.Habits.Habit

  import Ecto.Changeset

  @required_fields ~w(title user_id)a
  @optional_fields ~w(due_date notes habit_id complete? active? deleted? task_list_id parent_id)a

  @habit_required_fields ~w(habit_id user_id due_date)a

  @all_fields @required_fields ++ @optional_fields

  @update_allowed_fields ~w(due_date title notes complete? active? deleted?)a

  schema "tasks" do
    field :active?, :utc_datetime
    field :complete?, :utc_datetime
    field :deleted?, :utc_datetime
    field :due_date, :date
    field :notes, :string
    field :title, :string
    field :position, :integer

    belongs_to :parent, __MODULE__, foreign_key: :parent_id
    belongs_to :task_list, TaskList
    belongs_to :habit, Habit
    belongs_to :user, User

    has_many :subtasks, __MODULE__,
      foreign_key: :parent_id,
      preload_order: [asc: :position],
      where: [complete?: nil]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 1, max: 512)
  end

  def habit_changeset(task, attrs) do
    task
    |> cast(attrs, @all_fields)
    |> validate_required(@habit_required_fields)
  end

  def update_changeset(task, attrs) do
    task
    |> cast(attrs, @update_allowed_fields)
  end
end
