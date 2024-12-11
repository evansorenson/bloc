defmodule BlocWeb.TodayLive do
  @moduledoc false
  use BlocWeb, :live_view

  alias Bloc.Events.TaskListCreated
  alias Bloc.Events.TaskListDeleted
  alias Bloc.Events.TaskListUpdated
  alias Bloc.Tasks

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Tasks.subscribe(socket.assigns.scope)
    end

    {:ok, assign(socket, current_day: TimeUtils.today(socket.assigns.scope))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-screen flex overflow-hidden">
      <div class="flex-1 flex">
        <div class="flex-none w-96">
          <.live_component
            id="day_tasks"
            module={BlocWeb.DayTaskList}
            day={@current_day}
            scope={@scope}
          />
        </div>

        <div class="flex-none w-64">
          <.live_component
            id="calendar"
            module={BlocWeb.CalendarComponent}
            scope={@scope}
            day={@current_day}
          />
        </div>

        <div class="flex-1">
          <.live_component
            id="task-lists"
            module={BlocWeb.TaskLive.TasksComponent}
            scope={@scope}
          />
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("hide_reward_modal", _params, socket) do
    {:noreply, assign(socket, reward: nil)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    socket
    |> apply_action(socket.assigns.live_action, params)
    |> Tuples.noreply()
  end

  defp apply_action(socket, :index, _params) do
    assign(socket, :page_title, "Today")
  end

  @impl true
  def handle_info({:day_changed, new_day}, socket) do
    {:noreply, assign(socket, current_day: new_day)}
  end

  def handle_info({Tasks, %TaskListCreated{task_list: task_list}}, socket) do
    send_update(BlocWeb.TaskLive.TasksComponent, id: "tasks", task_list: task_list)
    {:noreply, socket}
  end

  def handle_info({Tasks, %TaskListUpdated{task_list: task_list}}, socket) do
    send_update(BlocWeb.TaskLive.TasksComponent, id: "tasks", task_list: task_list)
    {:noreply, socket}
  end

  def handle_info({Tasks, %TaskListDeleted{task_list: task_list}}, socket) do
    send_update(BlocWeb.TaskLive.TasksComponent, id: "tasks", task_list: task_list)
    {:noreply, socket}
  end

  def handle_info({Tasks, %{task: task} = event}, socket) do
    unless task.habit_id do
      send_update(BlocWeb.TaskLive.TaskListComponent, id: "task_lists-#{task.task_list_id}", event: event)
    end

    if task.parent_id do
      send_update(BlocWeb.TaskLive.TaskComponent, id: "day_tasks-#{task.parent_id}", event: event)
    else
      send_update(BlocWeb.DayTaskList, id: "day_tasks", event: event)
    end

    {:noreply, assign(socket, reward: Map.get(event, :reward))}
  end
end
