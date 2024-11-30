defmodule BlocWeb.RewardLive.FormComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Rewards

  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white p-6">
      <div class="mb-6">
        <div class="flex items-center gap-3">
          <%= case @action do %>
            <% :new -> %>
              <div class="bg-indigo-100 p-2.5 rounded-lg">
                <.icon name="hero-gift" class="h-5 w-5 text-indigo-600" />
              </div>
            <% :edit -> %>
              <div class="bg-indigo-100 p-2.5 rounded-lg">
                <.icon name="hero-pencil" class="h-5 w-5 text-indigo-600" />
              </div>
          <% end %>
          <div>
            <h2 class="text-xl font-semibold text-gray-900"><%= @title %></h2>
            <p class="mt-1 text-sm text-gray-500">Configure your task completion rewards</p>
          </div>
        </div>
      </div>

      <.simple_form
        for={@form}
        id="reward-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
        class="space-y-6"
      >
        <div class="space-y-4">
          <.input
            field={@form[:title]}
            type="text"
            label="Title"
            placeholder="Enter reward title"
            class="w-full rounded-lg border-gray-300 focus:border-indigo-500 focus:ring-indigo-500"
          />

          <.input
            field={@form[:description]}
            type="textarea"
            label="Description"
            placeholder="Describe your reward"
            class="w-full rounded-lg border-gray-300 focus:border-indigo-500 focus:ring-indigo-500"
          />

          <div class="border border-gray-100 rounded-lg p-4 bg-gray-50">
            <div class="flex justify-between items-center mb-2">
              <label class="block text-sm font-medium text-gray-700">Probability</label>
              <div class="flex items-center gap-2">
                <.input
                  field={@form[:probability]}
                  type="number"
                  step="any"
                  min="0"
                  max="100"
                  pattern="^\d*(\.\d{0,3})?$"
                  class="w-24 text-right rounded-md border-gray-300 focus:border-indigo-500 focus:ring-indigo-500"
                  phx-hook="ProbabilityInput"
                />
                <span class="text-sm font-medium text-indigo-600">%</span>
              </div>
            </div>
            <.input
              field={@form[:probability]}
              type="range"
              label=""
              min="0"
              max="100"
              step=".001"
              pattern="^\d*(\.\d{0,3})?$"
              class="w-full accent-indigo-600"
              phx-hook="RangeSlider"
            />
            <div class="flex justify-between text-xs text-gray-400 mt-1">
              <span>Rare</span>
              <span>Common</span>
            </div>
          </div>

          <div class="flex items-center">
            <.input
              field={@form[:active?]}
              type="checkbox"
              label="Active"
              class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
            />
          </div>
        </div>

        <div class="flex justify-end gap-3 pt-4 border-t border-gray-100">
          <.button
            type="button"
            phx-click="cancel"
            class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50"
          >
            Cancel
          </.button>
          <.button
            type="submit"
            phx-disable-with="Saving..."
            class="px-4 py-2 text-sm font-medium text-white bg-indigo-600 rounded-lg hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            <%= if @action == :new, do: "Create Reward", else: "Update Reward" %>
          </.button>
        </div>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{reward: reward} = assigns, socket) do
    changeset = Rewards.change_reward(reward)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"reward" => reward_params}, socket) do
    changeset =
      socket.assigns.reward
      |> Rewards.change_reward(reward_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"reward" => reward_params}, socket) do
    save_reward(socket, socket.assigns.action, reward_params)
  end

  def handle_event("update_probability", %{"value" => value}, socket) when is_float(value) do
    probability_changeset(socket, value)
  end

  def handle_event("update_probability", %{"value" => value}, socket) when is_binary(value) do
    case Float.parse(value) do
      {probability, _} -> probability_changeset(socket, probability)
      :error -> probability_changeset(socket, nil)
    end
  end

  defp probability_changeset(socket, probability) do
    changeset =
      socket.assigns.reward
      |> Rewards.change_reward(%{"probability" => probability})
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  defp save_reward(socket, :edit, reward_params) do
    case Rewards.update_reward(socket.assigns.reward, reward_params) do
      {:ok, reward} ->
        notify_parent({:saved, reward})

        {:noreply,
         socket
         |> put_flash!(:info, "Reward updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_reward(socket, :new, reward_params) do
    case Rewards.create_reward(reward_params, socket.assigns.scope) do
      {:ok, reward} ->
        notify_parent({:saved, reward})

        {:noreply,
         socket
         |> put_flash!(:info, "Reward created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
