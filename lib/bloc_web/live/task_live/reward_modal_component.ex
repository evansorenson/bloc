defmodule BlocWeb.TaskLive.RewardModalComponent do
  use BlocWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto p-8 text-center">
      <div class="mx-auto flex h-24 w-24 items-center justify-center rounded-full bg-green-100 mb-6">
        <.icon name="hero-gift" class="h-12 w-12 text-green-600" />
      </div>

      <div class="animate-fade-in">
        <h2 class="text-3xl font-bold text-gray-900 mb-4">🎉 Congratulations!</h2>
        <p class="text-xl text-gray-600 mb-6">You've earned a reward for completing your task</p>

        <div class="bg-white rounded-lg p-6 mb-8 shadow-sm border border-gray-100">
          <h3 class="text-2xl font-semibold text-gray-900 mb-2"><%= @reward.title %></h3>
          <p class="text-gray-600"><%= @reward.description %></p>
        </div>

        <button
          phx-click={JS.push("claim_reward", target: @myself) |> hide_modal("reward-modal")}
          class="inline-flex items-center px-6 py-3 border border-transparent text-lg font-medium rounded-md shadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors duration-150"
        >
          Claim Your Reward
        </button>
      </div>
    </div>
    """
  end

  def handle_event("claim_reward", _, socket) do
    {:noreply, socket}
  end
end
