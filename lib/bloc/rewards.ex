defmodule Bloc.Rewards do
  @moduledoc false
  import Ecto.Query

  alias Bloc.Repo
  alias Bloc.Rewards.Reward
  alias Bloc.Scope

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
end
