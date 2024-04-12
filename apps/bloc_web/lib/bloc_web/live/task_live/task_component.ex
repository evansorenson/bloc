defmodule BlocWeb.TaskLive.TaskComponent do
  use BlocWeb, :live_component

  alias Bloc.Scope
  alias Bloc.Tasks
  alias Bloc.Tasks.Task

  attr(:task, Task, required: true)
  attr(:subtask, Task, default: nil)

  attr(:scope, Scope, required: true)
  attr(:parent_dom_id, :string, required: true)
  attr(:parent_task_id, :string, default: nil)

  @impl true
  def render(assigns) do
    ~H"""
    <li
      id={@id}
      data-id={@task.id}
      class={"#{if is_nil(@task.id), do: "hidden"} drag-ghost:opacity-0"}
    >
      <div class={[
        "relative group flex items-center py-1 pl-2 hover:bg-gray-50 rounded-md #{if not is_nil(@parent_task_id), do: "pl-8", else: ""} ",
        if(is_nil(@task.id) || @task.due_date, do: "", else: "pb-1")
      ]}>
        <input
          aria-describedby="tasks-description"
          name="tasks"
          type="checkbox"
          class="h-3 w-3 rounded border-gray-300 text-indigo-600 focus:ring-0 focus-within:"
          phx-click="complete"
          checked={@task.complete?}
          disabled={is_nil(@task.id)}
          phx-target={@myself}
        />
        <div class="ml-3">
          <div class="text-sm leading-6">
            <%= if is_nil(@task.id) do %>
              <.simple_form for={@form} phx-submit="save" phx-change="validate" phx-target={@myself}>
                <.input
                  field={@form[:title]}
                  type="text"
                  class="h-4 block w-full group-hover:bg-gray-50 hover:bg-gray-50 ring-0 rounded-md text-gray-900 placeholder:text-gray-400 sm:text-sm border-none focus:ring-0 focus:border-none"
                  placeholder="New Task"
                />
              </.simple_form>
            <% else %>
              <label for="tasks" class="font-semibold text-gray-900"><%= @task.title %></label>
            <% end %>
          </div>
          <div :if={@task.due_date}>
            <span class="inline-flex items-center gap-x-1.5 rounded-md bg-gray-100 px-1.5 py-0.5 text-xs font-light text-gray-600">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-3 h-3"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5"
                />
              </svg>

              <%= Calendar.strftime(@task.due_date, "%m-%d") %>
            </span>
          </div>
        </div>

        <div class="flex ml-auto place-items-center">
          <div
            :if={@task.id}
            phx-click={new_subtask(@id)}
            class="opacity-0 group-hover:opacity-100 py-2 px-2"
          >
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

      <ul
        :if={not is_nil(@task.id) and is_nil(@parent_task_id)}
        id={"subtasks-#{@id}"}
        phx-update="stream"
        role="list"
        phx-hook="Sortable"
        data-group="tasks"
      >
        <.live_component
          module={BlocWeb.TaskLive.TaskComponent}
          scope={@scope}
          id={"new-subtask-#{@id}"}
          task={@subtask}
          parent_dom_id={@id}
          parent_task_id={@task.id}
        />

        <%= for {id, task} <- @streams.subtasks do %>
          <.live_component
            module={BlocWeb.TaskLive.TaskComponent}
            scope={@scope}
            id={id}
            task={task}
            parent_dom_id={@id}
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

  def update(%{task: %Task{parent_id: nil, subtasks: subtasks} = task} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:count, length(subtasks))
     |> assign(:subtask, %Task{parent_id: task.id})
     |> stream(:subtasks, subtasks)}
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
    IO.inspect("saving subtask")
    save_task(socket, :new, task_params)
  end

  @impl true
  def handle_event("complete", _params, socket) do
    complete? = if socket.assigns.task.complete?, do: nil, else: DateTime.utc_now()

    case Tasks.update_task(socket.assigns.task, %{complete?: complete?}) do
      {:ok, task} ->
        notify_parent({:saved, %{task: task, dom_id: socket.assigns.parent_dom_id}})

        {:noreply,
         socket
         |> put_flash(:info, "Task completed")}

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
         |> put_flash(:info, "Task updated successfully")}

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
        IO.inspect(task, label: "task")
        notify_parent({:saved, %{task: task, dom_id: socket.assigns.parent_dom_id}})

        {:noreply,
         socket
         |> put_flash(:info, "Task created successfully")
         |> assign_form(Tasks.change_task(%Task{task_list_id: task.task_list_id, title: ""}))}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
