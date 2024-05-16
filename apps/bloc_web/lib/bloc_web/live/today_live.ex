defmodule BlocWeb.TodayLive do
  @moduledoc false
  use BlocWeb, :live_view

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full flex md:pl-20 ">
      <%= live_render(@socket, BlocWeb.BlockLive.Index, id: "Blocks", scope: @scope) %>
      <.live_component
        id="today"
        module={BlocWeb.DayTaskList}
        day={TimeUtils.today(@scope)}
        scope={@scope}
      />
      <%= live_render(@socket, BlocWeb.TaskLive.Index, id: "Tasks", scope: @scope) %>
    </div>
    <%!-- task list integrations sidebar --%>
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
