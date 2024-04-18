defmodule BlocWeb.TaskLive.TaskComponent do
  alias Bloc.Repo
  use BlocWeb, :live_component

  alias Bloc.Scope
  alias Bloc.Tasks
  alias Bloc.Tasks.Task

  attr(:task, Task, required: true)
  attr(:subtask, Task, default: nil)

  attr(:scope, Scope, required: true)
  attr(:parent_task_id, :string, default: nil)
  attr(:static?, :boolean, default: false)

  @impl true
  def render(assigns) do
    ~H"""
    <li
      id={@id}
      data-id={@task.id}
      data-event="add_block"
      class={"#{if is_nil(@task.id), do: "hidden"} #{if not @static?, do: "sortable"} drag-ghost:opacity-0 z-30"}
      phx-value-duration="30"
      draggable="true"
      ondragstart="dragStart(event)"
      phx-click-away={if is_nil(@task.id), do: JS.hide()}
    >
      <div class={[
        "relative group flex items-start pl-2 hover:bg-gray-100 focus-within:bg-gray-100 rounded-md #{if not is_nil(@parent_task_id), do: "pl-8", else: ""} ",
        if(is_nil(@task.id) || @task.due_date || @task.estimated_minutes, do: "", else: "pb-1")
      ]}>
        <input
          aria-describedby="tasks-description"
          name="tasks"
          type="checkbox"
          class="h-3 w-3 mt-1.5 rounded border-gray-300 text-indigo-600 focus:ring-0 focus-within:"
          phx-click="complete"
          checked={@task.complete?}
          disabled={is_nil(@task.id)}
          phx-target={@myself}
        />
        <div class="ml-3 w-full">
          <div class="text-sm leading-6">
            <%= if is_nil(@task.id) do %>
              <.simple_form for={@form} phx-submit="save" phx-change="validate" phx-target={@myself}>
                <.input
                  id={"#{@id}-title-input"}
                  field={@form[:title]}
                  type="text"
                  class="-ml-3 h-6 block w-11/12 group-hover:bg-gray-100 hover:bg-gray-100 ring-0 rounded-md text-gray-900 font-medium placeholder:text-gray-400 sm:text-sm border-none focus:bg-gray-100 focus:ring-0 focus:border-none leading-none"
                  placeholder="New Task"
                  errors?={false}
                  label?={false}
                />
              </.simple_form>
            <% else %>
              <label for="tasks" class="font-medium text-gray-900"><%= @task.title %></label>
            <% end %>
          </div>

          <div class="flex align-middle mb-1 space-x-1">
            <div :if={@task.due_date}>
              <span class="inline-flex items-center gap-x-1.5 rounded-md bg-white border px-1 py-0.5 text-xs font-light text-gray-800">
                <.icon name="hero-calendar" class="h-3 w-3" />

                <%= Calendar.strftime(@task.due_date, "%m-%d") %>
              </span>
            </div>

            <div :if={@task.estimated_minutes}>
              <span class="inline-flex items-center gap-x-1.5 rounded-md bg-white border px-1 py-0.5 text-xs font-light text-gray-800">
                <.icon name="hero-clock" class="h-3 w-3" />
                <%= BlocWeb.Util.minutes_to_string(@task.estimated_minutes) %>
              </span>
            </div>
          </div>
        </div>

        <div :if={@task.id} class="flex ml-auto place-items-center">
          <div phx-click={new_subtask(@id)} class="opacity-0 group-hover:opacity-100 py-2 px-2">
            <.icon name="hero-plus" />
          </div>
          <div
            phx-click={toggle_subtasks(@id)}
            class={"cursor-pointer #{if @task.id && !@task.parent_id && @count > 0, do: "", else: "hidden"}"}
          >
            <.icon id={"subtasks-chevron-left-#{@id}"} name="hero-chevron-left" class="hidden" />

            <.icon id={"subtasks-chevron-down-#{@id}"} name="hero-chevron-down" />
          </div>
        </div>
      </div>

      <.live_component
        :if={not is_nil(@task.id) and is_nil(@parent_task_id)}
        module={BlocWeb.TaskLive.TaskComponent}
        scope={@scope}
        id={"new-subtask-#{@id}"}
        task={@subtask}
        parent_task_id={@task.id}
        static?={true}
      />

      <ul
        :if={not is_nil(@task.id) and is_nil(@parent_task_id)}
        id={"subtasks-#{@id}"}
        phx-update="stream"
        role="list"
        data-group="tasks"
      >
        <%= for {id, task} <- @streams.subtasks do %>
          <.live_component
            module={BlocWeb.TaskLive.TaskComponent}
            scope={@scope}
            id={id}
            task={task}
            parent_task_id={@task.id}
          />
        <% end %>
      </ul>
    </li>
    """
  end

  def toggle_subtasks(id) do
    JS.toggle(to: "#subtasks-chevron-left-#{id}")
    |> JS.toggle(to: "#subtasks-chevron-down-#{id}")
    |> JS.toggle(to: "#subtasks-#{id}")
  end

  def new_subtask(id) do
    JS.hide(to: "#subtasks-chevron-left-#{id}")
    |> JS.show(to: "#subtasks-chevron-down-#{id}")
    |> JS.show(to: "#subtasks-#{id}")
    |> JS.show(to: "#new-subtask-#{id}")
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
     |> assign(:subtask, %Task{parent_id: task.id})
     |> stream(:subtasks, task.subtasks)}
  end

  @impl true
  def update(%{subtask: subtask}, socket) do
    {:ok,
     socket
     |> stream_insert(:subtasks, subtask)
     |> assign(:count, socket.assigns.count + 1)
     |> assign(subtask: %Task{parent_id: subtask.parent_id})}
  end

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
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
    complete? = if socket.assigns.task.complete?, do: nil, else: DateTime.utc_now()

    case Tasks.update_task(socket.assigns.task, %{complete?: complete?}) do
      {:ok, task} ->
        notify_parent({:saved, task})

        {:noreply,
         socket
         |> put_flash!(:info, "Task completed")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  @impl true
  def handle_event("new_subtask", _unsigned_params, socket) do
    {:noreply, socket |> assign(subtask: %Task{parent_id: socket.assigns.task.id})}
  end

  defp save_task(socket, :edit, task_params) do
    case Tasks.update_task(socket.assigns.task, task_params) do
      {:ok, task} ->
        notify_parent({:saved, task})

        {:noreply,
         socket
         |> put_flash!(:info, "Task updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_task(socket, :new, task_params) do
    task_params
    |> Map.put("user_id", socket.assigns.scope.current_user_id)
    |> Map.put("task_list_id", socket.assigns.task.task_list_id)
    |> Map.put("parent_id", socket.assigns[:parent_task_id])
    |> Tasks.create_task()
    |> case do
      {:ok, task} ->
        notify_parent({:saved, task})

        {:noreply,
         socket
         |> put_flash!(:info, "Task created successfully")
         |> assign_form(Tasks.change_task(%Task{task_list_id: task.task_list_id, title: ""}))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
