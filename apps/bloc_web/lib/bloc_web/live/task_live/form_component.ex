defmodule BlocWeb.TaskLive.FormComponent do
  use BlocWeb, :live_component

  alias Bloc.Tasks

  attr(:scope, Bloc.Scope, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage task records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="task-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:notes]} type="text" label="Notes" />
        <.input field={@form[:due_date]} type="date" label="Due Date" />
        <.input
          field={@form[:estimated_minutes]}
          type="select"
          label="Estimate"
          options={[
            "15m": 15,
            "30m": 30,
            "45m": 45,
            "1h": 60,
            "1h 30m": 90,
            "2h": 120,
            "2h 30m": 150,
            "3h": 180
          ]}
        />

        <.input
          field={@form[:task_list_id]}
          type="select"
          label="Task List"
          options={
            for task_list <- @task_lists do
              {task_list.title, task_list.id}
            end
          }
        />

        <:actions>
          <.button phx-disable-with="Saving...">Save Task</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{task: task} = assigns, socket) do
    changeset = Tasks.change_task(task)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(task_lists: Tasks.list_task_lists(assigns.scope))
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"task" => task_params}, socket) do
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
         |> put_flash!(:info, "Task updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_task(socket, :new, task_params) do
    task_params
    |> Map.put("user_id", socket.assigns.scope.current_user_id)
    |> Tasks.create_task()
    |> case do
      {:ok, task} ->
        notify_parent({:saved, task})

        {:noreply,
         socket
         |> put_flash!(:info, "Task created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> put_flash!(:error, "Error creating task")
         |> assign_form(changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
