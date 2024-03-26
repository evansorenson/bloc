defmodule Bloc.Blocks.Block do
  use Bloc.Schema
  import Ecto.Changeset

  schema "blocks" do
    field :title, :string
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime

    belongs_to(:user, Bloc.Accounts.User)

    timestamps()
  end

  @required_fields ~w(title start_time end_time user_id)a
  @all_fields @required_fields

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
  end
end
