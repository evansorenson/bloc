defmodule Bloc.Tasks.TaskList do
  use Bloc.Schema
  import Ecto.Changeset

  schema "task_lists" do
    field :position, :integer
    field :title, :string
    field :color, :string
    field :user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task_list, attrs) do
    task_list
    |> cast(attrs, [:title, :position, :color])
    |> validate_required([:title, :position, :color])
  end
end
