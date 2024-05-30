defmodule BlocWeb.TaskLive.JiraComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Tasks
  alias Phoenix.LiveView.AsyncResult

  @impl true
  def update(assigns, socket) do
    socket
    |> assign(assigns)
    |> assign(:tasks, AsyncResult.loading())
    |> start_async(:fetch_tasks, fn -> Tasks.list_for_integration(assigns.scope, :jira) end)
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
  def render(assigns) do
    ~H"""
    <div class="text-stone-700 h-screen border-l-gray-100 border-l-2 basis-[17.13rem] flex-col text-sm font-medium flex border-solid">
      <div class="px-5 pt-4">
        <div class="text-xl font-semibold">
          <div class="items-center flex">
            <div class="cursor-pointer text-ellipsis">Jira</div>
            <i></i>
          </div>
        </div>
        <%!-- <div>
          <div class="items-center cursor-pointer flex">
            <div class="text-xs font-semibold text-ellipsis">My open issues</div>
            <i class="pl-1"></i>
          </div>
        </div>
        <div class="items-center flex text-xs text-neutral-500">
          <div class="flex-grow flex">
            <div class="items-center cursor-pointer py-1 px-1.5 flex rounded">Imported: Show</div>
          </div>
          <div class="items-center cursor-pointer py-1 px-1.5 flex rounded">
            <div class="pr-1"><i class="inline-block"></i></div>
            Refresh
          </div>
        </div> --%>
      </div>
      <div class="flex-col h-full flex p-2">
        <div class="bg-white cursor-pointer flex-col flex border-2 border-zinc-100 border-solid rounded">
          <div class="items-center flex-grow px-3 flex">
            <div class="text-zinc-400 items-center text-xs justify-center flex font-semibold">
              <button class="text-neutral-500 bg-zinc-100 items-start text-[0.63rem] py-1 px-1.5 text-center w-8 h-5 rounded">
                JQL
              </button>
            </div>
            <input
              value=""
              placeholder="Search by JQL"
              class="cursor-text flex-grow opacity-[0.65] text-ellipsis w-48 h-8 p-1"
            />
          </div>
        </div>
        <div class="flex-col overflow-y-scroll space-y-2 mt-2">
          <.async_result assign={@tasks}>
            <:loading>
              <div
                :for={_ <- 1..5}
                class="bg-gray-100 border-b-zinc-300 border-r-zinc-300 border-t-zinc-300 cursor-pointer flex-col flex rounded p-3"
              >
                <div class="animate-pulse flex space-x-4">
                  <div class="flex-1 space-y-4 py-1">
                    <div class="h-4 bg-gray-400 rounded w-3/4"></div>
                    <div class="space-y-2">
                      <div class="h-4 bg-gray-400 rounded"></div>
                      <div class="h-4 bg-gray-400 rounded w-5/6"></div>
                    </div>
                  </div>
                </div>
              </div>
            </:loading>
            <:failed>
              <div class="bg-gray-100 border-b-zinc-300 border-r-zinc-300 border-t-zinc-300 cursor-pointer flex-col flex rounded p-3">
                <div class="text-neutral-500 text-center">Failed to load tasks</div>
              </div>
            </:failed>
            <%= for {_id,  task} <- @streams.tasks do %>
              <div class="bg-gray-100 border-b-zinc-300 border-r-zinc-300 border-t-zinc-300 cursor-pointer flex-col flex rounded p-3">
                <%= task.fields["summary"] %>
                <div class="flex">
                  <img
                    src="https://api.atlassian.com/ex/jira/18ab8147-c1c9-4ba0-9593-52270e4bd65d/rest/api/2/universal_avatar/view/type/issuetype/avatar/11665?size=medium"
                    style="break-inside: avoid;"
                    class="items-center justify-center opacity-50 flex w-5 h-5 rounded p-1"
                  />
                  <div class="text-neutral-500 items-center text-xs justify-center flex rounded">
                    <%= task.key %>
                  </div>
                  <div class="text-zinc-400">
                    <a
                      href="https://billcom.atlassian.net/browse/GOLD-2452"
                      class="items-center justify-center flex rounded"
                    >
                      <i></i>
                    </a>
                  </div>
                  <div class="items-center flex-grow justify-end flex">
                    <img
                      src="https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/6226264d302c6b006af49e0a/1147a2b8-a2bc-40e4-85de-b95fdcf9003c/48"
                      style="break-inside: avoid;"
                      class="items-center justify-center flex w-5 h-5 rounded-full"
                    />
                  </div>
                </div>

                <div class="flex align-middle mb-1 space-x-1">
                  <div class="text-neutral-500 items-center text-xs justify-center flex rounded bg-white px-2">
                    <%= task.fields["status"]["name"] %>
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
