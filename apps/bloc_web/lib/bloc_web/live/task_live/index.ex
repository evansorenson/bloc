defmodule BlocWeb.TaskLive.Index do
  alias BlocWeb.TaskLive.TaskComponent
  alias BlocWeb.TaskLive.TaskListComponent
  alias Bloc.Utils.Ok
  alias Bloc.Tasks.TaskList
  use BlocWeb, :live_view

  alias Bloc.Tasks
  alias Bloc.Tasks.Task

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> stream(:tasks, Tasks.list_tasks(socket.assigns.scope))
    |> stream(:task_lists, Tasks.list_task_lists(socket.assigns.scope))
    |> Ok.wrap()
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task")
    |> assign(:task, Tasks.get_task!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{})
  end

  defp apply_action(socket, :new_list, _params) do
    socket
    |> assign(:page_title, "New Task List")
    |> assign(:task_list, %TaskList{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tasks")
    |> assign(:task, nil)
    |> assign(:task_list, nil)
  end

  @impl true
  def handle_info(
        {_component, {:saved, %Task{parent_id: parent_id} = subtask}},
        socket
      )
      when is_binary(parent_id) do
    send_update(TaskComponent, id: "tasks-#{parent_id}", subtask: subtask)
    {:noreply, socket}
  end

  def handle_info(
        {_component, {:saved, %Task{} = task}},
        socket
      ) do
    send_update(TaskListComponent, id: "task_lists-#{task.task_list_id}", task: task)
    {:noreply, socket}
  end

  def handle_info({_component, {:saved, %TaskList{} = task_list}}, socket) do
    {:noreply, stream_insert(socket, :task_lists, task_list)}
  end

  def handle_info({_component, {:task_scheduled, %{task: task, block: block}}}, socket) do
    IO.inspect("task scheduled")

    send_update(TaskListComponent,
      id: "task_lists-#{task.task_list_id}",
      task: task,
      block: block
    )

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task = Tasks.get_task!(id)
    {:ok, _} = Tasks.delete_task(task)

    {:noreply, stream_delete(socket, :tasks, task)}
  end
end
