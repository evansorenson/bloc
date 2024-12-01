defmodule BlocWeb.TaskLive.FormComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Tasks

  attr(:scope, Bloc.Scope, required: true)
  attr(:on_save, :any, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white p-6">
      <div class="mb-6">
        <div class="flex items-center gap-3">
          <%= case @action do %>
            <% :new_task -> %>
              <div class="bg-indigo-100 p-2.5 rounded-lg">
                <.icon name="hero-plus" class="h-5 w-5 text-indigo-600" />
              </div>
            <% :edit_task -> %>
              <div class="bg-indigo-100 p-2.5 rounded-lg">
                <.icon name="hero-pencil" class="h-5 w-5 text-indigo-600" />
              </div>
          <% end %>
          <div>
            <h2 class="text-xl font-semibold text-gray-900"><%= @title %></h2>
            <p class="mt-1 text-sm text-gray-500">Configure your task details</p>
          </div>
        </div>
      </div>

      <.simple_form
        for={@form}
        id="task-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
        class="space-y-6"
      >
        <div class="grid grid-cols-1 gap-6">
          <div>
            <.input
              field={@form[:title]}
              type="text"
              label="Title"
              class="w-full"
            />
          </div>

          <div>
            <.input
              field={@form[:notes]}
              type="textarea"
              label="Notes"
              class="w-full"
            />
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <.input
                field={@form[:due_date]}
                type="date"
                label="Due Date"
                class="w-full"
              />
            </div>
            <div>
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
                class="w-full"
              />
            </div>
          </div>

          <div>
            <.input
              field={@form[:task_list_id]}
              type="select"
              label="Task List"
              prompt="No list"
              options={
                for task_list <- @task_lists do
                  {task_list.title, task_list.id}
                end
              }
              class="w-full"
            />
          </div>
        </div>

        <div class="mt-6 flex justify-end gap-3">
          <.button
            type="button"
            phx-click={JS.exec("data-cancel", to: "##{@id}")}
            class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            Cancel
          </.button>
          <.button
            type="submit"
            phx-disable-with="Saving..."
            class="inline-flex justify-center px-4 py-2 text-sm font-medium text-white bg-indigo-600 border border-transparent rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            Save Task
          </.button>
        </div>
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

  defp save_task(socket, :edit_task, task_params) do
    case Tasks.update_task(socket.assigns.task, task_params, socket.assigns.scope) do
      {:ok, _task} ->
        socket.assigns.on_save.()
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_task(socket, :new_task, task_params) do
    task_params
    |> Map.put("user_id", socket.assigns.scope.current_user_id)
    |> Tasks.create_task(socket.assigns.scope)
    |> case do
      {:ok, _task} ->
        socket.assigns.on_save.()
{:noreply, socket}

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

end
