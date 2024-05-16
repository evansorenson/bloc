defmodule Bloc.Blocks.Block do
  @moduledoc false
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:user]

  import Ecto.Changeset

  alias Ecto.Changeset

  schema "blocks" do
    field :title, :string
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime

    belongs_to(:task, Bloc.Tasks.Task)
    belongs_to(:user, Bloc.Accounts.User)

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(title start_time end_time user_id)a
  @all_fields @required_fields

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
    |> validate_start_time()
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
