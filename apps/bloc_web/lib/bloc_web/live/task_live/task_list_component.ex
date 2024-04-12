defmodule BlocWeb.TaskLive.TaskListComponent do
  use BlocWeb, :live_component

  alias Bloc.Tasks.TaskList
  alias Bloc.Tasks.Task
  alias Bloc.Repo

  attr(:task_list, TaskList, required: true)
  attr(:id, :string, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id} class="">
      <div class="flex w-full group">
        <h3 class="text-md font-medium text-gray-900"><%= @task_list.title %></h3>
        <p class="pl-4"><%= @count %></p>

        <div class="ml-auto flex">
          <div phx-click={new_task(@id)} role="button" class="opacity-0 group-hover:opacity-100">
            <.icon name="hero-plus" />
          </div>

          <div phx-click={toggle_tasks(@id)} class="cursor-pointer">
            <.icon id={"list-chevron-left-#{@id}"} name="hero-chevron-left" />

            <.icon id={"list-chevron-down-#{@id}"} name="hero-chevron-down" class="hidden" />
          </div>
        </div>
      </div>

      <ul id={"list-tasks-#{@id}"} phx-update="stream" role="list" class="hidden">
        <.live_component
          module={BlocWeb.TaskLive.TaskComponent}
          scope={@scope}
          id={"new_task-#{@id}"}
          task={@task}
          parent_dom_id={@id}
        />

        <%= for {id, task} <- @streams.tasks do %>
          <.live_component
            module={BlocWeb.TaskLive.TaskComponent}
            scope={@scope}
            id={id}
            task={task}
            parent_dom_id={@id}
          />
        <% end %>
      </ul>
    </div>
    """
  end

  def toggle_tasks(id) do
    JS.toggle(to: "#list-chevron-left-#{id}")
    |> JS.toggle(to: "#list-chevron-down-#{id}")
    |> JS.toggle(to: "#list-tasks-#{id}")
  end

  def new_task(id) do
    JS.hide(to: "#list-chevron-left-#{id}")
    |> JS.show(to: "#list-chevron-down-#{id}")
    |> JS.show(to: "#list-tasks-#{id}")
    |> JS.show(to: "#new-task-#{id}")
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

  def update(%{task: inserted_task}, socket) do
    {:ok,
     socket
     |> assign(:count, socket.assigns.count + 1)
     |> stream_insert(:tasks, inserted_task)}
  end

  @impl true
  def handle_event("new_task", _unsigned_params, socket) do
    {:noreply, socket |> assign(task: %Task{task_list_id: socket.assigns.task_list.id})}
  end
end
