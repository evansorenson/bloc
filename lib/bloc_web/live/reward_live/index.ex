defmodule BlocWeb.RewardLive.Index do
  @moduledoc false
  use BlocWeb, :live_view

  alias Bloc.Rewards
  alias Bloc.Rewards.Reward

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> stream(:rewards, Rewards.list_rewards(socket.assigns.scope))
    |> stream(:reward_history, Rewards.list_reward_history(socket.assigns.scope))
    |> Tuples.ok()
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info({_component, {:saved, %Reward{} = reward}}, socket) do
    {:noreply, stream_insert(socket, :rewards, reward)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Reward")
    |> assign(:reward, Rewards.get_reward!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Reward")
    |> assign(:reward, %Reward{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rewards")
    |> assign(:reward, nil)
  end

  @impl true
  def handle_event("redeem_reward", %{"id" => id}, socket) do
    case Rewards.redeem_reward(id) do
      {:ok, _reward_history} ->
        reward_history = Rewards.list_reward_history(socket.assigns.scope)
        {:noreply, assign(socket, :reward_history, reward_history)}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end
end
