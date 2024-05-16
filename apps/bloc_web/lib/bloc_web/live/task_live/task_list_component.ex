defmodule BlocWeb.TaskLive.TaskListComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Repo
  alias Bloc.Tasks
  alias Bloc.Tasks.Task
  alias Bloc.Tasks.TaskList

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
  def update(%{task_list: task_list} = assigns, socket) do
    task_list = Repo.preload(task_list, tasks: :subtasks)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(task: %Task{task_list_id: task_list.id})
     |> assign(:count, length(task_list.tasks))
     |> stream(:tasks, task_list.tasks)}
  end

  def update(%{task: task, block: _block}, socket) do
    remove_task(socket, task)
  end

  def update(%{task: %Task{complete?: complete?, deleted?: deleted?} = removed_task}, socket)
      when not is_nil(complete?) or not is_nil(deleted?) do
    remove_task(socket, removed_task)
  end

  def update(%{task: %Task{} = inserted_task}, socket) do
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
end
