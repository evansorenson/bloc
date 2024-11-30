defmodule Bloc.Rewards.Reward do
  @moduledoc false
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:user]

  import Ecto.Changeset

  alias Bloc.Accounts.User

  schema "rewards" do
    field :title, :string
    field :description, :string
    field :probability, :float
    field :active?, :boolean, default: true
    field :deleted?, :utc_datetime

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(title probability user_id)a
  @optional_fields ~w(description active? deleted?)a
  @all_fields @required_fields ++ @optional_fields

  def changeset(reward, attrs) do
    reward
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
    |> validate_number(:probability, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
    |> validate_length(:title, min: 1, max: 255)
  end
end
