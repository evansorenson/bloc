defmodule BlocWeb.TaskLive.CheckboxComponent do
  use BlocWeb, :live_component

  alias Bloc.Tasks
  alias Bloc.Tasks.Task

  attr(:task, Task, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div class="relative flex items-start">
      <div class="flex h-6 items-center">
        <input
          id="tasks"
          aria-describedby="tasks-description"
          name="tasks"
          type="checkbox"
          class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-600"
        />
      </div>
      <div class="ml-3 text-sm leading-6">
        <label for="tasks" class="font-medium text-gray-900"><%= @task.title %></label>
      </div>
    </div>
    """
  end

  @impl true
  def update(%{task: task} = assigns, socket) do
    changeset = Tasks.change_task(task)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"task" => task_params}, socket) do
    task_params = Map.put(task_params, "user_id", socket.assigns.current_user.id)

    changeset =
      socket.assigns.task
      |> Tasks.change_task(task_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"task" => task_params}, socket) do
    save_task(socket, socket.assigns.action, task_params)
  end

  defp save_task(socket, :edit, task_params) do
    case Tasks.update_task(socket.assigns.task, task_params) do
      {:ok, task} ->
        notify_parent({:saved, task})

        {:noreply,
         socket
         |> assign(:disabled, true)
         |> put_flash(:info, "Task updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_task(socket, :new, task_params) do
    task_params
    |> Map.put("user_id", socket.assigns.current_user.id)
    |> Tasks.create_task()
    |> case do
      {:ok, task} ->
        notify_parent({:saved, task})

        {:noreply,
         socket
         |> assign(:disabled, true)
         |> put_flash(:info, "Task created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
