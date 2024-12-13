defmodule BlocWeb.TaskLive.TasksComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Tasks
  alias Bloc.Tasks.Task
  alias Bloc.Tasks.TaskList

  require Logger

  @impl true
  def update(assigns, socket) do
    scope = assigns.scope
    task_lists = Tasks.list_task_lists(scope)

    # Get unassigned tasks
    # Get tasks where habit_id is nil and task_list_id is nil
    unassigned_tasks = Tasks.list_tasks(scope, habit_id: :none, task_list_id: :none, parent_id: :none)

    # Create virtual unassigned list
    unassigned_list = %TaskList{
      id: nil,
      title: "Unassigned",
      position: -1,
      color: "gray-200",
      tasks: unassigned_tasks
    }

    # Add unassigned list if there are unassigned tasks
    task_lists =
      if length(unassigned_tasks) > 0 do
        task_lists ++ [unassigned_list]
      else
        task_lists
      end

    socket
    |> assign(assigns)
    |> assign(:current_view, "tasks")
    |> stream(:task_lists, task_lists)
    |> apply_action(:index, %{})
    |> Tuples.ok()
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full h-full flex">
      <div class={[
        "flex-1 flex",
        @current_view == "jira" && "hidden"
      ]}>
        <div class="px-4 py-4 sm:px-6 md:overflow-y-auto md:border-l md:border-gray-200 md:py-6 md:px-8 md:block">
          <.header>
            Tasks
            <:actions>
              <.button phx-target={@myself} phx-click="new_task">New Task</.button>
              <.button phx-target={@myself} phx-click="new_task_list">New List</.button>
            </:actions>
          </.header>

          <div class="my-8 space-y-4" phx-update="stream" id="task-lists">
            <%= for {id, task_list} <- @streams.task_lists do %>
              <.live_component
                module={BlocWeb.TaskLive.TaskListComponent}
                scope={@scope}
                id={id}
                task_list={task_list}
              />
            <% end %>
          </div>
        </div>
      </div>

      <%= if @current_view == "jira" do %>
        <.live_component module={BlocWeb.TaskLive.JiraComponent} id="jira-tasks" scope={@scope} />
      <% end %>

      <div class="flex-none w-16 bg-gray-50 backdrop-blur-md flex flex-col items-center py-6 border-l border-gray-100">
        <nav class="flex flex-col items-center space-y-4">
          <button
            phx-click="switch_view"
            phx-target={@myself}
            phx-value-view="tasks"
            class={[
              "p-2.5 rounded-xl transition-all duration-200",
              "hover:bg-gray-50/80 hover:scale-105 active:scale-95",
              @current_view == "tasks" && "bg-gray-200 shadow-sm"
            ]}
            aria-label="Tasks view"
          >
            <.icon
              name="hero-check-circle"
              class={[
                "h-6 w-6 transition-colors duration-200",
                @current_view == "tasks" && "text-green-500",
                @current_view != "tasks" && "text-green-400/70 hover:text-green-500"
              ]}
            />
          </button>
          <button
            phx-click="switch_view"
            phx-target={@myself}
            phx-value-view="jira"
            class={[
              "p-2 rounded-lg transition-colors duration-200",
              @current_view == "jira" && "bg-gray-200"
            ]}
            aria-label="Jira view"
          >
            <.icon
              name="hero-command-line"
              class={[
                "h-5 w-5",
                @current_view == "jira" && "text-blue-400",
                @current_view != "jira" && "text-blue-400/60 hover:text-blue-400"
              ]}
            />
          </button>
        </nav>
      </div>

      <.modal
        :if={@live_action in [:new_task, :edit_task]}
        id="task-modal"
        show
        on_cancel={JS.push("cancel", target: @myself)}
      >
        <.live_component
          module={BlocWeb.TaskLive.FormComponent}
          id={@task.id || :new}
          on_save={fn -> JS.push("saved", target: @myself) end}
          title={@page_title}
          action={@live_action}
          task={@task}
          return_to={~p"/tasks"}
          scope={@scope}
        />
      </.modal>

      <.modal
        :if={@live_action in [:new_list, :edit_list]}
        id="task_list-modal"
        show
        on_cancel={JS.push("cancel", target: @myself)}
      >
        <.live_component
          module={BlocWeb.TaskLive.ListFormComponent}
          id={@task_list.id || :new_list}
          on_save={fn -> JS.push("saved", target: @myself) end}
          title={@page_title}
          action={@live_action}
          task_list={@task_list}
          patch={~p"/tasks"}
          scope={@scope}
        />
      </.modal>
    </div>
    """
  end

  defp apply_action(socket, action, params \\ %{})

  defp apply_action(socket, :edit_task, %{"id" => id}) do
    socket
    |> assign(:task, Tasks.get_task!(id))
    |> assign(:live_action, :edit_task)
    |> assign(:page_title, "Edit Task")
  end

  defp apply_action(socket, :new_task, _params) do
    socket
    |> assign(:task, %Task{})
    |> assign(:live_action, :new_task)
    |> assign(:page_title, "New Task")
  end

  defp apply_action(socket, :new_list, _params) do
    socket
    |> assign(:task_list, %TaskList{})
    |> assign(:live_action, :new_list)
    |> assign(:page_title, "New List")
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:task, nil)
    |> assign(:task_list, nil)
    |> assign(:live_action, :index)
  end

  # @impl true
  # def handle_info({_component, {:saved, %Task{parent_id: parent_id} = subtask}}, socket) when is_binary(parent_id) do
  #   send_update(TaskComponent, id: "tasks-#{parent_id}", subtask: subtask)

  #   {:noreply, socket}
  # end

  # def handle_info({_component, {:saved, %Task{} = task}}, socket) do
  #   send_update(TaskListComponent, id: "task_lists-#{task.task_list_id}", task: task)
  #   {:noreply, socket}
  # end

  # def handle_info({_component, {:task_scheduled, %{task: task, block: block}}}, socket) do
  #   send_update(TaskListComponent,
  #     id: "task_lists-#{task.task_list_id}",
  #     task: task,
  #     block: block
  #   )

  #   {:noreply, socket}
  # end

  # def handle_info({_component, {:saved, %TaskList{} = task_list}}, socket) do
  #   {:noreply, stream_insert(socket, :task_lists, task_list)}
  # end

  @impl true
  def handle_event("switch_view", %{"view" => view}, socket) do
    {:noreply, assign(socket, :current_view, view)}
  end

  def handle_event("cancel", _params, socket) do
    socket |> apply_action(:index) |> Tuples.noreply()
  end

  def handle_event("new_task", _params, socket) do
    socket |> apply_action(:new_task) |> Tuples.noreply()
  end

  def handle_event("edit_task", params, socket) do
    socket |> apply_action(:edit_task, params) |> Tuples.noreply()
  end

  def handle_event("new_task_list", _, socket) do
    socket |> apply_action(:new_list) |> Tuples.noreply()
  end

  def handle_event("delete", %{"id" => id}, socket) do
    task = Tasks.get_task!(id)
    {:ok, _} = Tasks.delete_task(task, socket.assigns.scope)

    {:noreply, stream_delete(socket, :tasks, task)}
  end

  def handle_event("saved", _params, socket) do
    Logger.debug("saved tasks")
    socket |> apply_action(:index) |> Tuples.noreply()
    {:noreply, socket}
  end
end
