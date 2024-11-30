defmodule BlocWeb.TaskLive.ListFormComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Tasks

  attr(:scope, Bloc.Scope, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage task_list records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="task_list-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:position]} type="number" label="Position" />
        <.input field={@form[:color]} type="text" label="Color" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Task list</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{task_list: task_list} = assigns, socket) do
    changeset = Tasks.change_task_list(task_list)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"task_list" => task_list_params}, socket) do
    changeset =
      socket.assigns.task_list
      |> Tasks.change_task_list(task_list_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"task_list" => task_list_params}, socket) do
    save_task_list(socket, socket.assigns.action, task_list_params)
  end

  defp save_task_list(socket, :edit_list, task_list_params) do
    case Tasks.update_task_list(socket.assigns.task_list, task_list_params, socket.assigns.scope) do
      {:ok, _task_list} ->
        {:noreply,
         socket
         |> put_flash!(:info, "Task list updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_task_list(socket, :new_list, task_list_params) do
    task_list_params
    |> Tasks.create_task_list(socket.assigns.scope)
    |> case do
      {:ok, _task_list} ->
        {:noreply,
         socket
         |> put_flash!(:info, "Task list created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> put_flash!(:error, "Error creating task") |> assign_form(changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
