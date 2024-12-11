defmodule Bloc.Tasks.TaskList do
  @moduledoc false
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:tasks]

  import Ecto.Changeset

  schema "task_lists" do
    field :position, :integer
    field :title, :string
    field :color, :string

    belongs_to :user, Bloc.Accounts.User

    has_many :tasks, Bloc.Tasks.Task,
      on_delete: :delete_all,
      preload_order: [asc: :position],
      where: [complete?: nil]

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(title position color user_id)a
  @update_fields ~w(title position color)a

  @doc false
  def changeset(task_list, attrs) do
    task_list
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

  def update_changeset(task_list, attrs) do
    task_list
    |> cast(attrs, @update_fields)
    |> validate_required(@update_fields)
  end
end
