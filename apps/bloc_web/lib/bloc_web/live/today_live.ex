defmodule BlocWeb.TodayLive do
  @moduledoc false
  use BlocWeb, :live_view

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full flex md:pl-20 ">
      <.live_component id="today-calendar" module={BlocWeb.CalendarComponent} scope={@scope} />
      <.live_component
        id="today"
        module={BlocWeb.DayTaskList}
        day={TimeUtils.today(@scope)}
        scope={@scope}
      />

      <div
        style="border-bottom-style: solid; border-left-style: solid; word-break: break-word;"
        class="text-stone-700 border-b-zinc-100 border-b-2 border-l-zinc-100 border-l-2 flex-col pb-20 pt-11 flex overflow-y-auto bg-stone-50"
      >
        <div class="text-neutral-500">
          <div class="items-center cursor-pointer justify-center opacity-60 flex w-8 h-8 rounded-xl m-2 p-1.5">
            <img
              src="https://s3-us-west-2.amazonaws.com/assets.siftnet.com/integrations/google/gcal-icon-128-min.png"
              style="break-inside: avoid;"
              class="blur-[1px] w-full h-full max-w-full"
            />
          </div>
        </div>
        <div>
          <div class="bg-neutral-500/[0.2] items-center cursor-pointer justify-center flex w-8 h-8 rounded-xl m-2 p-1.5">
            <img
              src="https://s3-us-west-2.amazonaws.com/assets.siftnet.com/integrations/jira/jira-icon-128-min.png"
              style="break-inside: avoid;"
              class="w-full h-full max-w-full"
            />
          </div>
        </div>
        <div class="text-neutral-500">
          <div class="items-center cursor-pointer justify-center opacity-60 flex w-8 h-8 rounded-xl m-2 p-1.5">
            <img
              src="https://s3-us-west-2.amazonaws.com/assets.siftnet.com/integrations/google/gmail-icon-128-min.png"
              style="break-inside: avoid;"
              class="blur-[1px] w-full h-full max-w-full"
            />
          </div>
        </div>
        <div class="text-neutral-500">
          <div class="items-center cursor-pointer justify-center opacity-60 flex w-8 h-8 rounded-xl m-2 p-1.5">
            <i class="w-5"></i>
          </div>
        </div>
        <div class="text-neutral-500">
          <div class="items-center cursor-pointer justify-center opacity-60 flex w-8 h-8 rounded-xl m-2 p-1.5">
            <i class="w-5"></i>
          </div>
        </div>
        <div class="text-neutral-500">
          <div class="items-center cursor-pointer justify-center opacity-60 flex w-8 h-8 rounded-xl m-2 p-1.5">
            <i class="w-5"></i>
          </div>
        </div>
        <div class="text-neutral-500">
          <div class="items-center cursor-pointer justify-center opacity-60 flex w-8 h-8 rounded-xl m-2 p-1.5">
            <i class="w-5"></i>
          </div>
        </div>
        <div class="text-neutral-500 items-center cursor-pointer justify-center opacity-60 flex w-8 h-8 rounded-xl m-2 p-1.5">
          <i class="w-5"></i>
        </div>
        <div class="text-neutral-500 items-center cursor-pointer justify-center opacity-60 flex w-8 h-8 rounded-xl m-2 p-1.5">
          <i class="w-5"></i>
        </div>
      </div>

      <.live_component id="today-jira" module={BlocWeb.TaskLive.JiraComponent} scope={@scope} />
      <.live_component id="today-tasks" module={BlocWeb.TaskLive.TasksComponent} scope={@scope} />
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    Tuples.ok(socket)
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
end
