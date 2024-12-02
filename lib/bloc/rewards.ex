defmodule Bloc.Rewards do
  @moduledoc false
  import Ecto.Query

  alias Bloc.Repo
  alias Bloc.Rewards.Reward
  alias Bloc.Scope
  alias Bloc.Rewards.RewardHistory

  def list_rewards(%Scope{current_user_id: user_id}) do
    Reward
    |> where([r], r.user_id == ^user_id and is_nil(r.deleted?))
    |> Repo.all()
  end

  def get_reward!(id), do: Repo.get!(Reward, id)

  def create_reward(attrs \\ %{}, %Scope{current_user_id: user_id}) do
    attrs
    |> Map.put("user_id", user_id)
    |> then(&Reward.changeset(%Reward{}, &1))
    |> Repo.insert()
  end

  def update_reward(%Reward{} = reward, attrs) do
    reward
    |> Reward.changeset(attrs)
    |> Repo.update()
  end

  def delete_reward(%Reward{} = reward) do
    update_reward(reward, %{deleted?: DateTime.utc_now()})
  end

  def select_random_reward(%Scope{current_user_id: user_id}) do
    rewards =
      Reward
      |> where([r], r.user_id == ^user_id and r.active? == true and is_nil(r.deleted?))
      |> Repo.all()

    rewards
    |> Enum.filter(fn reward ->
      random_number = :rand.uniform(1_000_000) / 10_000.0
      random_number <= reward.probability
    end)
    |> Enum.random()
  rescue
    Enum.EmptyError -> nil
  end

  def change_reward(%Reward{} = reward, attrs \\ %{}) do
    Reward.changeset(reward, attrs)
  end

  def create_reward_history(nil, _task, _scope), do: {:ok, nil}

  def create_reward_history(reward, task, %Scope{current_user_id: user_id}) do
    %{
      "user_id" => user_id,
      "reward_id" => reward.id,
      "task_id" => task && task.id,
      "received_at" => DateTime.utc_now()
    }
    |> then(&RewardHistory.changeset(%RewardHistory{}, &1))
    |> dbg()
    |> Repo.insert()
  end

  def redeem_reward(reward_history_id) do
    reward_history = get_reward_history!(reward_history_id)

    reward_history
    |> RewardHistory.changeset(%{"redeemed_at" => DateTime.utc_now()})
    |> Repo.update()
  end

  def list_reward_history(%Scope{current_user_id: user_id}) do
    RewardHistory
    |> where([rh], rh.user_id == ^user_id)
    |> preload([:reward])
    |> order_by([rh], desc: rh.received_at)
    |> Repo.all()
  end

  def get_reward_history!(id), do: Repo.get!(RewardHistory, id)
end
