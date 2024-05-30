defmodule BlocWeb.TaskLive.TasksComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Tasks
  alias Bloc.Tasks.Task
  alias Bloc.Tasks.TaskList

  @impl true
  def update(assigns, socket) do
    socket
    |> assign(assigns)
    |> stream(:task_lists, Tasks.list_task_lists(assigns.scope))
    |> apply_action(:index, %{})
    |> Tuples.ok()
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full flex md:pl-20">
      <div class="flex-none w-96 px-4 py-4 sm:px-6 md:overflow-y-auto md:border-r md:border-gray-200 md:py-6 md:px-8 md:block">
        <.header>
          Tasks
          <:actions>
            <.button phx-target={@myself} phx-click="new_task">New Task</.button>
            <.button phx-target={@myself} phx-click="new_task_list">New List</.button>
          </:actions>
        </.header>

        <%!-- <div class="mt-2" phx-update="stream" id="tasks">
    <%= for {id, task} <- @streams.tasks do %>
    <.live_component module={BlocWeb.TaskLive.TaskComponent} id={id} task={task} />
    <% end %>
    </div>
    --%>

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

        <%!-- <.table
    id="tasks"
    rows={@streams.tasks}
    row_click={fn {_id, task} -> JS.navigate(~p"/tasks/#{task}") end}
    >
    <:col :let={{_id, task}} label="Title"><%= task.title %></:col>
    <:col :let={{_id, task}} label="Notes"><%= task.notes %></:col>
    <:col :let={{_id, task}} label="Is complete"><%= task.complete? %></:col>
    <:col :let={{_id, task}} label="Is active"><%= task.active? %></:col>
    <:col :let={{_id, task}} label="Due date"><%= task.due_date %></:col>
    <:action :let={{_id, task}}>
    <div class="sr-only">
      <.link navigate={~p"/tasks/#{task}"}>Show</.link>
    </div>
    <.link patch={~p"/tasks/#{task}/edit"}>Edit</.link>
    </:action>
    <:action :let={{id, task}}>
    <.link
      phx-click={JS.push("delete", value: %{id: task.id}) |> hide("##{id}")}
      data-confirm="Are you sure?"
    >
      Delete
    </.link>
    </:action>
    </.table> --%>

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
            patch={~p"/tasks"}
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
    {:ok, _} = Tasks.delete_task(task)

    {:noreply, stream_delete(socket, :tasks, task)}
  end
end
