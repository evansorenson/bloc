defmodule BlocWeb.TaskLive.Show do
  @moduledoc false
  use BlocWeb, :live_view

  alias Bloc.Tasks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:task, Tasks.get_task!(id))}
  end

  defp page_title(:show), do: "Show Task"
  defp page_title(:edit), do: "Edit Task"
end
