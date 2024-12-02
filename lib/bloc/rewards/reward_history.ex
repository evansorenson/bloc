defmodule Bloc.Rewards.RewardHistory do
  @moduledoc false
  use Bloc.Schema
  use QueryBuilder, assoc_fields: [:user, :reward, :task]

  import Ecto.Changeset

  alias Bloc.Accounts.User
  alias Bloc.Rewards.Reward
  alias Bloc.Tasks.Task

  schema "reward_history" do
    belongs_to :user, User
    belongs_to :reward, Reward
    belongs_to :task, Task

    field :redeemed_at, :utc_datetime
    field :received_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(user_id reward_id received_at)a
  @optional_fields ~w(task_id redeemed_at)a
  @all_fields @required_fields ++ @optional_fields

  def changeset(reward_history, attrs) do
    reward_history
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
  end
end
