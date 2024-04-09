defmodule BlocWeb.TaskListLive.Index do
  use BlocWeb, :live_view

  alias Bloc.Tasks
  alias Bloc.Tasks.TaskList

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :task_lists, Tasks.list_task_lists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task list")
    |> assign(:task_list, Tasks.get_task_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task list")
    |> assign(:task_list, %TaskList{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Task lists")
    |> assign(:task_list, nil)
  end

  @impl true
  def handle_info({BlocWeb.TaskListLive.FormComponent, {:saved, task_list}}, socket) do
    {:noreply, stream_insert(socket, :task_lists, task_list)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task_list = Tasks.get_task_list!(id)
    {:ok, _} = Tasks.delete_task_list(task_list)

    {:noreply, stream_delete(socket, :task_lists, task_list)}
  end
end
