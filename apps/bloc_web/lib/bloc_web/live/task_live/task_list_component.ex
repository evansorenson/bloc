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
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="2.0"
              stroke="currentColor"
              class="w-4 h-4 text-gray-500 hover:text-gray-800 cursor-pointer"
            >
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
            </svg>
          </div>

          <div phx-click={toggle_tasks(@id)} class="cursor-pointer">
            <svg
              id={"list-chevron-left-#{@id}"}
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="w-6 h-6"
            >
              <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
            </svg>

            <svg
              id={"list-chevron-down-#{@id}"}
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="w-6 h-6 hidden"
            >
              <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
            </svg>
          </div>
        </div>
      </div>

      <ul id={"list-tasks-#{@id}"} phx-update="stream" role="list" class="hidden">
        <.live_component
          module={BlocWeb.TaskLive.TaskComponent}
          scope={@scope}
          id={"new_task-#{@id}"}
          task={@task}
          task_list_dom_id={@id}
        />

        <%= for {id, task} <- @streams.tasks do %>
          <.live_component
            module={BlocWeb.TaskLive.TaskComponent}
            scope={@scope}
            id={id}
            task={task}
            task_list_dom_id={@id}
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
    task_list = Repo.preload(task_list, [:tasks])

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
