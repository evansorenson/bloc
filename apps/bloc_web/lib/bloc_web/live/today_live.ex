defmodule BlocWeb.TodayLive do
  @moduledoc false
  use BlocWeb, :live_view

  alias Bloc.Events.TaskListCreated
  alias Bloc.Events.TaskListDeleted
  alias Bloc.Events.TaskListUpdated
  alias Bloc.Tasks

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full h-screen flex overflow-hidden">
      <div class="flex pr-96">
        <.live_component
          id={"day_tasks_#{TimeUtils.today(@scope) |> Date.to_string()}"}
          module={BlocWeb.DayTaskList}
          day={TimeUtils.today(@scope)}
          scope={@scope}
        />

        <.live_component
          id={"calendar_#{TimeUtils.today(@scope) |> Date.to_string()}"}
          module={BlocWeb.CalendarComponent}
          scope={@scope}
          day={TimeUtils.today(@scope)}
        />
      </div>

      <div class="flex flex-1 min-w-0">
        <div class="flex-1">
          <.live_component id="task-lists" module={BlocWeb.TaskLive.TasksComponent} scope={@scope} />
        </div>
      </div>

      <.modal :if={@reward} id="reward-modal" show on_cancel={JS.push("hide_reward_modal")}>
        <div class="max-w-2xl mx-auto p-8 text-center">
          <div class="mx-auto flex h-24 w-24 items-center justify-center rounded-full bg-green-100 mb-6">
            <.icon name="hero-gift" class="h-12 w-12 text-green-600" />
          </div>

          <div class="animate-fade-in">
            <h2 class="text-3xl font-bold text-gray-900 mb-4">🎉 Congratulations!</h2>
            <p class="text-xl text-gray-600 mb-6">You've earned a reward for completing your task</p>

            <div class="bg-white rounded-lg p-6 mb-8 shadow-sm border border-gray-100">
              <h3 class="text-2xl font-semibold text-gray-900 mb-2"><%= @reward.title %></h3>
              <p class="text-gray-600"><%= @reward.description %></p>
            </div>

            <button
              phx-click={hide_modal("reward-modal")}
              class="inline-flex items-center px-6 py-3 border border-transparent text-lg font-medium rounded-md shadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors duration-150"
            >
              Claim Your Reward
            </button>
          </div>
        </div>
      </.modal>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Tasks.subscribe(socket.assigns.scope)
    end

    {:ok, assign(socket, :reward, nil)}
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
  def handle_event("hide_reward_modal", _params, socket) do
    {:noreply, assign(socket, reward: nil)}
  end

  @impl true
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

    send_update(BlocWeb.DayTaskList,
      id: "day_tasks_#{socket.assigns.scope |> TimeUtils.today() |> Date.to_string()}",
      event: event
    )

    {:noreply, assign(socket, reward: Map.get(event, :reward))}
  end
end
