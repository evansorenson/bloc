defmodule BlocWeb.TaskLive.JiraComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Tasks
  alias Phoenix.LiveView.AsyncResult

  @impl true
  def update(assigns, socket) do
    scope = assigns.scope

    socket
    |> assign(assigns)
    |> assign(:tasks, AsyncResult.loading())
    |> start_async(:fetch_tasks, fn -> Tasks.list_for_integration(scope, :jira) end)
    |> Tuples.ok()
  end

  @impl true
  def handle_async(:fetch_tasks, {:ok, {:ok, fetched_tasks}}, socket) do
    socket
    |> assign(:tasks, AsyncResult.ok(:ok))
    |> stream(:tasks, fetched_tasks)
    |> Tuples.noreply()
  end

  def handle_async(:fetch_tasks, {:ok, {:error, error}}, socket) do
    tasks = socket.assigns.tasks
    {:noreply, assign(socket, :tasks, AsyncResult.failed(tasks, {:error, error}))}
  end

  def handle_async(:fetch_tasks, {:exit, reason}, socket) do
    tasks = socket.assigns.tasks
    {:noreply, assign(socket, :tasks, AsyncResult.failed(tasks, {:exit, reason}))}
  end

  @impl true
  def handle_event("refresh", _params, socket) do
    scope = socket.assigns.scope

    socket
    |> assign(:tasks, AsyncResult.loading())
    |> start_async(:fetch_tasks, fn -> Tasks.list_for_integration(scope, :jira) end)
    |> Tuples.noreply()
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-full flex-none w-80 bg-white flex flex-col border-l border-gray-200">
      <div class="flex-none p-4 border-b border-gray-200">
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <div class="bg-blue-50 p-2 rounded-lg">
              <.icon name="hero-command-line" class="h-5 w-5 text-blue-600" />
            </div>
            <div>
              <h2 class="text-base font-semibold text-gray-900">Jira Tasks</h2>
              <p class="mt-0.5 text-xs text-gray-500">Your assigned issues</p>
            </div>
          </div>
        </div>
      </div>

      <div class="flex-1 overflow-y-auto p-4">
        <div class="space-y-2">
          <.async_result :let={_} assign={@tasks}>
            <:loading>
              <div class="animate-pulse space-y-3">
                <%= for _i <- 1..3 do %>
                  <div class="relative group flex items-start p-3 hover:bg-gray-50 rounded-lg border border-gray-200">
                    <div class="w-full space-y-3">
                      <div class="h-4 bg-gray-200 rounded w-3/4"></div>
                      <div class="flex gap-2">
                        <div class="h-5 w-5 bg-gray-200 rounded-full"></div>
                        <div class="h-5 bg-gray-200 rounded w-1/4"></div>
                      </div>
                    </div>
                  </div>
                <% end %>
              </div>
            </:loading>
            <:failed>
              <div class="text-center p-4">
                <div class="inline-flex items-center justify-center w-12 h-12 rounded-full bg-red-100 mb-3">
                  <.icon name="hero-exclamation-triangle" class="h-6 w-6 text-red-600" />
                </div>
                <h3 class="text-sm font-medium text-gray-900">Failed to load tasks</h3>
                <p class="mt-1 text-sm text-gray-500">Please try again later</p>
              </div>
            </:failed>
            <%= for {id, task} <- @streams.tasks do %>
              <div
                id={id}
                draggable="true"
                data-jira-key={task.key}
                data-jira-summary={task.fields["summary"]}
                ondragstart="dragStartJira(event)"
                class="relative group flex items-start p-2.5 hover:bg-gray-50 rounded"
              >
                <div class="flex-grow min-w-0">
                  <div class="flex items-center gap-2 mb-1.5">
                    <img src={task.fields["issuetype"]["iconUrl"]} class="w-4 h-4" />
                    <span class="text-sm text-gray-900"><%= task.fields["summary"] %></span>
                  </div>

                  <div class="flex items-center gap-1.5">
                    <span class="px-1.5 py-0.5 text-xs text-gray-500 bg-gray-50 rounded">
                      <%= task.key %>
                    </span>
                    <span class="px-1.5 py-0.5 text-xs text-gray-500 bg-gray-50 rounded">
                      <%= task.fields["status"]["name"] %>
                    </span>
                  </div>
                </div>
              </div>
            <% end %>
          </.async_result>
        </div>
      </div>
    </div>
    """
  end
end
