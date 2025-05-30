defmodule BlocWeb.HabitLive.Show do
  @moduledoc false
  use BlocWeb, :live_view

  alias Bloc.Habits

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:habit, Habits.get_habit!(id))}
  end

  defp page_title(:show), do: "Show Habit"
  defp page_title(:edit), do: "Edit Habit"
end
