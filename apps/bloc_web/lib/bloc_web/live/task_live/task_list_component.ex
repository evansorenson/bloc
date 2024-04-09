# defmodule BlocWeb.TaskLive.TaskListComponent do
#   use BlocWeb, :live_component

#   alias Bloc.Tasks
#   alias Bloc.Tasks.Task

#   attr(:tasks, :list, required: true)

#   @impl true
#   def render(assigns) do
#     ~H"""
#     <div>
#       <%= for {id, task} <- @tasks do %>
#         <.live_component module={BlocWeb.TaskLive.CheckboxComponent} id={id} task={task} />
#       <% end %>
#     </div>
#     """
#   end

#   @impl true
#   def update(%{task: task} = assigns, socket) do
#     changeset = Tasks.change_task(task)

#     {:ok,
#      socket
#      |> assign(assigns)
#      |> assign_form(changeset)}
#   end

#   @impl true
#   def handle_event("validate", %{"task" => task_params}, socket) do
#     task_params = Map.put(task_params, "user_id", socket.assigns.current_user.id)

#     changeset =
#       socket.assigns.task
#       |> Tasks.change_task(task_params)
#       |> Map.put(:action, :validate)

#     {:noreply, assign_form(socket, changeset)}
#   end

#   def handle_event("save", %{"task" => task_params}, socket) do
#     save_task(socket, socket.assigns.action, task_params)
#   end

#   defp save_task(socket, :edit, task_params) do
#     case Tasks.update_task(socket.assigns.task, task_params) do
#       {:ok, task} ->
#         notify_parent({:saved, task})

#         {:noreply,
#          socket
#          |> assign(:disabled, true)
#          |> put_flash(:info, "Task updated successfully")}

#       {:error, %Ecto.Changeset{} = changeset} ->
#         {:noreply, assign_form(socket, changeset)}
#     end
#   end

#   defp save_task(socket, :new, task_params) do
#     task_params
#     |> Map.put("user_id", socket.assigns.current_user.id)
#     |> Tasks.create_task()
#     |> case do
#       {:ok, task} ->
#         notify_parent({:saved, task})

#         {:noreply,
#          socket
#          |> assign(:disabled, true)
#          |> put_flash(:info, "Task created successfully")}

#       {:error, %Ecto.Changeset{} = changeset} ->
#         {:noreply, assign_form(socket, changeset)}
#     end
#   end

#   defp assign_form(socket, %Ecto.Changeset{} = changeset) do
#     assign(socket, :form, to_form(changeset))
#   end

#   defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
# end
