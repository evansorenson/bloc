defmodule BlocWeb.TaskLive.TaskListComponent do
  use BlocWeb, :live_component

  alias Bloc.Tasks
  alias Bloc.Tasks.TaskList
  alias Bloc.Tasks.Task
  alias Bloc.Repo

  attr(:task_list, TaskList, required: true)
  attr(:id, :string, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id} class="">
      <div phx-click={toggle_tasks(@id)} class="flex w-full align-center group mb-2">
        <h3 class="text-md font-semibold text-gray-900"><%= @task_list.title %></h3>
        <p class="pl-4"><%= @count %></p>

        <button
          role="button"
          phx-click={new_task(@id)}
          role="button"
          class="ml-auto opacity-0 group-hover:opacity-100 hover:bg-gray-100 rounded-md block mr-2 mt-0"
        >
          <.icon name="hero-plus" />
        </button>
        <button role="button" phx-click={toggle_tasks(@id)} class="hover:bg-gray-100 rounded-md block">
          <.icon id={"list-chevron-left-#{@id}"} name="hero-chevron-left" />
        </button>
      </div>

      <.live_component
        module={BlocWeb.TaskLive.TaskComponent}
        scope={@scope}
        id={"new_task-#{@id}"}
        task={@task}
        static?={true}
      />

      <ul
        id={"list-tasks-#{@id}"}
        phx-update="stream"
        data-group="tasks"
        data-list_id={@id}
        role="list"
        class="hidden"
      >
        <%= for {id, task} <- @streams.tasks do %>
          <.live_component module={BlocWeb.TaskLive.TaskComponent} scope={@scope} id={id} task={task} />
        <% end %>
      </ul>
    </div>
    """
  end

  def toggle_tasks(id) do
    JS.toggle_class("-rotate-90", to: "#list-chevron-left-#{id}")
    |> JS.toggle(to: "#list-tasks-#{id}")
  end

  def new_task(id) do
    JS.add_class("-rotate-90", to: "#list-chevron-left-#{id}")
    |> JS.show(to: "#list-tasks-#{id}")
    |> JS.show(to: "#new_task-#{id}")
    |> JS.focus(to: "#new_task-#{id}-title-input")
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
    {:noreply, socket |> assign(task: %Task{task_list_id: socket.assigns.task_list.id})}
  end

  @impl true
  def handle_event(
        "reposition",
        %{"id" => _id, "new" => _new_position, "old" => _old_position},
        socket
      ) do
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
