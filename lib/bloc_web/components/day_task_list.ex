defmodule BlocWeb.DayTaskList do
  @moduledoc false
  use BlocWeb, :live_component

  import Ecto.Query

  alias Bloc.Events.TaskCompleted
  alias Bloc.Events.TaskCreated
  alias Bloc.Events.TaskDeleted
  alias Bloc.Events.TaskUpdated
  alias Bloc.Tasks

  require Logger

  attr(:day, Date, required: true)
  attr(:scope, Bloc.Scope, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-full bg-white flex flex-col border-r border-gray-200">
      <div class="flex-none px-4 py-3 border-b border-gray-200">
        <div class="flex items-center justify-between">
          <button phx-click="prev_day" phx-target={@myself} class="p-1 rounded hover:bg-gray-100">
            <.icon name="hero-chevron-left" class="h-5 w-5" />
          </button>

          <div class="flex items-baseline">
            <span class="text-base font-medium text-gray-900">
              {Calendar.strftime(@day, "%A")}
            </span>
            <span class="ml-2 text-sm text-gray-500">
              {Calendar.strftime(@day, "%B %d")}
            </span>
          </div>

          <button phx-click="next_day" phx-target={@myself} class="p-1 rounded hover:bg-gray-100">
            <.icon name="hero-chevron-right" class="h-5 w-5" />
          </button>
        </div>
      </div>

      <div
        id="day-tasks-container"
        class="flex-1 overflow-y-auto"
        ondragover="handleJiraTaskDragOver(event)"
        ondragleave="handleJiraTaskDragLeave(event)"
        ondrop="handleJiraTaskDrop(event)"
        phx-hook="JiraTaskDrop"
      >
        <div id="day_tasks_list" class="p-4 space-y-2" phx-update="stream">
          <%= for {id, task} <- @streams.day_tasks do %>
            <.live_component
              module={BlocWeb.TaskLive.TaskComponent}
              scope={@scope}
              id={id}
              task={task}
            />
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def update(%{event: %TaskCreated{task: task}}, socket) do
    if task.due_date == socket.assigns.day do
      Logger.debug("task created to day - added task", task_id: task.id)

      {:ok,
       socket
       |> stream_insert(:day_tasks, task)
       |> assign(:count, socket.assigns.count + 1)}
    else
      Logger.debug("task created to different day - ignored", task_id: task.id)
      {:ok, socket}
    end
  end

  def update(%{event: %TaskUpdated{task: task, old_task: old_task}}, socket) do
    if task.due_date == socket.assigns.day do
      Logger.debug("task updated to day - added task", task_id: task.id)

      {:ok, stream_insert(socket, :day_tasks, task)}
    else
      Logger.debug("task is different day - deleted task", task_id: old_task.id)
      {:ok, stream_delete(socket, :day_tasks, old_task)}
    end
  end

  def update(%{event: %TaskDeleted{task: task}}, socket) do
    Logger.debug("task deleted day task", task_id: task.id)
    {:ok, stream_delete(socket, :day_tasks, task)}
  end

  def update(%{event: %TaskCompleted{task: task}}, socket) do
    Logger.debug("task completed day task", task_id: task.id)
    {:ok, stream_delete(socket, :day_tasks, task)}
  end

  def update(assigns, socket) do
    Logger.debug("day task list update", day: assigns.day)

    tasks = list_tasks_for_day(assigns.day, assigns.scope)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:count, length(tasks))
     |> stream(:day_tasks, tasks)}
  end

  @impl true
  def handle_event("create_jira_task", %{"key" => jira_key, "summary" => summary}, socket) do
    bill_task_list = Tasks.get_task_list_by(socket.assigns.scope, title: "BILL")

    task_params = %{
      "title" => summary,
      "due_date" => socket.assigns.day,
      "user_id" => socket.assigns.scope.current_user_id,
      "jira_key" => jira_key,
      "task_list_id" => bill_task_list && bill_task_list.id
    }

    case Tasks.create_task(task_params, socket.assigns.scope) do
      {:ok, task} ->
        {:noreply,
         socket
         |> stream_insert(:day_tasks, task)
         |> put_flash(:info, "Task created from Jira ticket")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, put_flash(socket, :error, "Error creating task: #{inspect(changeset.errors)}")}
    end
  end

  def handle_event("prev_day", _, socket) do
    new_day = Date.add(socket.assigns.day, -1)

    {:noreply, socket |> assign(day: new_day) |> stream(:day_tasks, [], reset: true) |> send_day_changed()}
  end

  def handle_event("next_day", _, socket) do
    new_day = Date.add(socket.assigns.day, 1)

    {:noreply, socket |> assign(day: new_day) |> stream(:day_tasks, [], reset: true) |> send_day_changed()}
  end

  defp send_day_changed(socket) do
    send(self(), {:day_changed, socket.assigns.day})
    socket
  end

  defp list_tasks_for_day(day, scope) do
    Tasks.all_tasks_query(
      from(t in Bloc.Tasks.Task,
        where: is_nil(t.parent_id),
        where: (is_nil(t.habit_id) and t.due_date <= ^day) or (not is_nil(t.habit_id) and t.due_date == ^day)
      ),
      scope
    )
  end
end
