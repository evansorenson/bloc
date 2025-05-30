defmodule BlocWeb.TaskLive.TaskListComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Events.TaskCompleted
  alias Bloc.Events.TaskCreated
  alias Bloc.Events.TaskDeleted
  alias Bloc.Events.TaskUpdated
  alias Bloc.Tasks
  alias Bloc.Tasks.Task
  alias Bloc.Tasks.TaskList

  require Logger

  attr(:task_list, TaskList, required: true)
  attr(:id, :string, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.dropdown_list
        id={@id}
        title={@task_list.title}
        count={@count}
        delete?={@task_list.title != "Unassigned"}
        new_item_to_focus={"#new_task-#{@id}-title-input"}
      >
        <:new_item>
          <.live_component
            module={BlocWeb.TaskLive.TaskComponent}
            scope={@scope}
            id={"new_task-#{@id}"}
            task={@task}
            static?={true}
          />
        </:new_item>

        <:items>
          <ul
            id={"list-tasks-#{@id}"}
            phx-update="stream"
            data-group="tasks"
            data-list_id={@id}
            role="list"
          >
            <%= for {id, task} <- @streams.tasks do %>
              <.live_component
                module={BlocWeb.TaskLive.TaskComponent}
                scope={@scope}
                id={id}
                task={task}
              />
            <% end %>
          </ul>
        </:items>
      </.dropdown_list>
    </div>
    """
  end

  @impl true
  def update(%{task_list: %TaskList{tasks: tasks} = task_list} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:task_list, task_list)
     |> assign(task: %Task{task_list_id: task_list.id})
     |> assign(:count, length(tasks))
     |> stream(:tasks, tasks)}
  end

  def update(%{event: %TaskCompleted{task: %Task{} = completed_task}}, socket) do
    remove_task(socket, completed_task)
  end

  def update(%{event: %TaskDeleted{task: %Task{} = deleted_task}}, socket) do
    remove_task(socket, deleted_task)
  end

  def update(%{event: %TaskUpdated{task: %Task{} = updated_task}}, socket) do
    Logger.debug("updated task #{updated_task.id}")
    {:ok, stream_insert(socket, :tasks, updated_task)}
  end

  def update(%{event: %TaskCreated{task: %Task{} = inserted_task}}, socket) do
    Logger.debug("inserted task #{inserted_task.id}")

    {:ok,
     socket
     |> assign(:count, socket.assigns.count + 1)
     |> stream_insert(:tasks, inserted_task)}
  end

  defp remove_task(socket, task) do
    {:ok, socket |> assign(:count, socket.assigns.count - 1) |> stream_delete(:tasks, task)}
  end

  @impl true
  def handle_event("new_task", _unsigned_params, socket) do
    {:noreply, assign(socket, task: %Task{task_list_id: socket.assigns.task_list.id})}
  end

  @impl true
  def handle_event("reposition", %{"id" => _id, "new" => _new_position, "old" => _old_position}, socket) do
    # task = Tasks.get_task!(id)
    # {:noreply, socket |> stream_insert(:tasks, task, at: new_position)}
    {:noreply, socket}
  end

  @impl true
  def handle_event("scheduled_task", %{"id" => id}, socket) do
    {:noreply,
     socket
     |> stream_delete(:tasks, Tasks.get_task!(id))
     |> assign(:count, socket.assigns.count - 1)}
  end

  @impl true
  def handle_event("delete_list", _params, socket) do
    case Tasks.delete_task_list(socket.assigns.task_list, socket.assigns.scope) do
      {:ok, _task_list} ->
        {:noreply, socket}

      {:error, _changeset} ->
        {:noreply, put_flash!(socket, :error, "Could not delete task list")}
    end
  end
end
