defmodule BlocWeb.TaskLive.TaskComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Events.TaskCompleted
  alias Bloc.Events.TaskDeleted
  alias Bloc.Repo
  alias Bloc.Tasks
  alias Bloc.Tasks.Task

  require Logger

  # attr(:task, Task, required: true)
  # attr(:subtask, Task, default: nil)

  # attr(:scope, Scope, required: true)
  attr(:static?, :boolean, default: false)

  @impl true
  def mount(socket) do
    socket
    # |> stream_configure(:subtasks, dom_id: &"subtasks#{System.unique_integer()}-#{&1.id}")
    |> assign(:static?, socket.assigns[:static?] || false)
    |> Tuples.ok()
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div
      id={@id}
      data-id={@task.id}
      data-event="add_block"
      class={[
        !@task.id && !@task.parent_id && "hidden",
        not @static? && "sortable"
      ]}
      phx-value-duration="30"
      draggable="true"
      ondragstart="dragStart(event)"
      phx-click-away={if is_nil(@task.id) and !@task.parent_id, do: JS.hide()}
      phx-remove={JS.transition("fade-out duration-500")}
    >
      <div class={[
        "relative group flex items-start p-3 my-0.5 border-b border-gray-100 last:border-b-0 hover:bg-gray-50 focus-within:bg-gray-50 rounded-none transition-all duration-200",
        @task.parent_id && "ml-6"
      ]}>
        <div class="flex items-start space-x-3 w-full">
          <div class="flex-shrink-0 mt-1">
            <input
              aria-describedby="tasks-description"
              name="tasks"
              type="checkbox"
              class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500 disabled:opacity-50 disabled:cursor-not-allowed disabled:bg-gray-200"
              phx-click="complete"
              checked={@task.complete?}
              disabled={is_nil(@task.id) or (is_nil(@task.parent_id) and @count != 0)}
              phx-target={@myself}
            />
          </div>

          <div class="flex-grow min-w-0">
            <%= if is_nil(@task.id) do %>
              <.simple_form for={@form} phx-submit="save" phx-change="validate" phx-target={@myself}>
                <.input
                  id={"#{@id}-title-input"}
                  field={@form[:title]}
                  type="text"
                  class="block w-full text-sm text-gray-900 bg-transparent border-0 focus:ring-0 placeholder:text-gray-400"
                  placeholder="Task name"
                  errors?={false}
                  label?={false}
                />
                <div class="mt-2 flex gap-2">
                  <button
                    type="button"
                    class="inline-flex items-center text-xs text-gray-500 hover:text-gray-700"
                  >
                    <.icon name="hero-calendar" class="h-4 w-4 mr-1" /> Due date
                  </button>
                  <button
                    type="button"
                    class="inline-flex items-center text-xs text-gray-500 hover:text-gray-700"
                  >
                    <.icon name="hero-clock" class="h-4 w-4 mr-1" /> Estimate
                  </button>
                </div>
              </.simple_form>
            <% else %>
              <div class="text-sm text-gray-900 font-medium">
                <div class="flex items-center gap-2">
                  <%= if is_nil(@task.parent_id) && @task.habit_id do %>
                    <div class="flex-shrink-0">
                      <.icon name="hero-arrow-path" class="h-4 w-4 text-indigo-500" />
                    </div>
                    <%= if @task.habit.streak > 0 do %>
                      <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-md text-xs font-medium bg-orange-50 text-orange-700 border border-orange-200">
                        <.icon name="hero-fire" class="h-3.5 w-3.5 text-orange-500" />
                        {@task.habit.streak}
                      </span>
                    <% end %>
                  <% end %>
                  {@task.title}
                </div>
              </div>

              <div class="mt-1 flex items-center gap-2">
                <%= if @task.due_date && !@task.parent_id do %>
                  <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-md text-xs font-medium bg-gray-50 text-gray-600 border border-gray-200">
                    <%= case Date.diff(@task.due_date, TimeUtils.today(@scope)) do %>
                      <% 0 -> %>
                        <.icon name="hero-sun" class="h-3.5 w-3.5 text-amber-500" />
                        <span class="text-amber-700">Today</span>
                      <% 1 -> %>
                        <.icon name="hero-arrow-trending-up" class="h-3.5 w-3.5 text-blue-500" />
                        <span class="text-blue-700">Tomorrow</span>
                      <% _ -> %>
                        <.icon name="hero-calendar" class="h-3.5 w-3.5" />
                        {Calendar.strftime(@task.due_date, "%b %d")}
                    <% end %>
                  </span>
                <% end %>

                <%= if @task.estimated_minutes do %>
                  <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-md text-xs font-medium bg-gray-50 text-gray-600 border border-gray-200">
                    <.icon name="hero-clock" class="h-3.5 w-3.5" />
                    {TimeUtils.minutes_to_string(@task.estimated_minutes)}
                  </span>
                <% end %>
              </div>
            <% end %>
          </div>

          <%= if @task.id && !@task.parent_id do %>
            <div class="flex-shrink-0 flex items-center space-x-2 opacity-0 group-hover:opacity-100 transition-opacity">
              <button
                type="button"
                phx-click={new_subtask(@id) |> JS.push("new_subtask", target: @myself)}
                class="p-1 rounded-md hover:bg-gray-100"
              >
                <.icon name="hero-plus" class="h-4 w-4 text-gray-400" />
              </button>

              <%= if !@task.parent_id && @count > 0 do %>
                <button
                  type="button"
                  phx-click={toggle_subtasks(@id)}
                  class="p-1 rounded-md hover:bg-gray-100"
                >
                  <.icon name="hero-chevron-down" class="h-4 w-4 text-gray-400" />
                </button>
              <% end %>
            </div>
          <% end %>
        </div>
      </div>

      <%= if not is_nil(@task.id) and is_nil(@task.parent_id) do %>
        <%= if @subtask do %>
          <.live_component
            module={BlocWeb.TaskLive.TaskComponent}
            scope={@scope}
            id={"new-subtask-#{@id}"}
            task={@subtask}
            static?={true}
          />
        <% end %>

        <ul id={"subtasks-#{@id}"} phx-update="stream" role="list" data-group="tasks">
          <%= for {id, task} <- @streams.subtasks do %>
            <.live_component
              module={BlocWeb.TaskLive.TaskComponent}
              scope={@scope}
              id={id}
              task={task}
            />
          <% end %>
        </ul>
      <% end %>
    </div>
    """
  end

  def toggle_subtasks(id) do
    [to: "#subtasks-chevron-left-#{id}"]
    |> JS.toggle()
    |> JS.toggle(to: "#subtasks-chevron-down-#{id}")
    |> JS.toggle(to: "#subtasks-#{id}")
  end

  def new_subtask(id) do
    [to: "#subtasks-chevron-left-#{id}"]
    |> JS.hide()
    |> JS.show(to: "#subtasks-chevron-down-#{id}")
    |> JS.show(to: "#subtasks-#{id}")
    |> JS.show(to: "#new-subtask-#{id}")
    |> JS.focus(to: "#new-subtask-#{id}-title-input")
  end

  @impl true
  def update(%{event: %TaskDeleted{task: %{parent_id: parent_id} = task}}, socket)
      when parent_id == socket.assigns.task.id do
    Logger.debug("task deleted event - task component", task_id: task.id)
    {:ok, socket |> stream_delete(:subtasks, task) |> assign(:count, socket.assigns.count - 1)}
  end

  def update(%{event: %TaskCompleted{task: %{parent_id: parent_id} = task}}, socket)
      when parent_id == socket.assigns.task.id do
    Logger.debug("task completed event - task component", task_id: task.id)

    {:ok, socket |> stream_delete(:subtasks, task) |> assign(:count, socket.assigns.count - 1)}
  end

  def update(%{task: %Task{id: nil} = task} = assigns, socket) do
    changeset = Tasks.change_task(task)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  def update(%{task: %Task{parent_id: nil} = task} = assigns, socket) do
    task = Repo.preload(task, :subtasks)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:count, length(task.subtasks))
     |> assign(:subtask, nil)
     |> stream(:subtasks, task.subtasks)}
  end

  def update(%{subtask: %Task{complete?: complete?} = subtask}, socket) when not is_nil(complete?) do
    {:ok, socket |> stream_delete(:subtasks, subtask) |> assign(:count, socket.assigns.count - 1)}
  end

  def update(%{subtask: subtask}, socket) do
    {:ok,
     socket
     |> stream_insert(:subtasks, subtask)
     |> assign(:count, socket.assigns.count + 1)
     |> assign(subtask: %Task{parent_id: subtask.parent_id})}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("validate", %{"task" => task_params}, socket) do
    task_params = Map.put(task_params, "user_id", socket.assigns.scope.current_user.id)

    changeset =
      socket.assigns.task
      |> Tasks.change_task(task_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"task" => task_params}, socket) do
    save_task(socket, :new, task_params)
  end

  @impl true
  def handle_event("complete", _params, socket) do
    case Tasks.toggle_complete(socket.assigns.task, !socket.assigns.task.complete?, socket.assigns.scope) do
      {:ok, task} ->
        {:noreply, assign(socket, :task, task)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  @impl true
  def handle_event("new_subtask", _unsigned_params, socket) do
    {:noreply, assign(socket, subtask: %Task{parent_id: socket.assigns.task.id})}
  end

  defp save_task(socket, :edit, task_params) do
    case Tasks.update_task(socket.assigns.task, task_params, socket.assigns.scope) do
      {:ok, task} ->
        socket.assigns.on_save.(socket)

        {:noreply,
         socket
         |> put_flash!(:info, "Task updated successfully")
         |> assign(:task, task)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_task(socket, :new, task_params) do
    task_params
    |> Map.put("user_id", socket.assigns.scope.current_user_id)
    |> Map.put("task_list_id", socket.assigns.task.task_list_id)
    |> Map.put("parent_id", socket.assigns[:parent_task_id])
    |> Tasks.create_task(socket.assigns.scope)
    |> case do
      {:ok, _task} ->
        {:noreply, put_flash!(socket, :info, "Task created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
