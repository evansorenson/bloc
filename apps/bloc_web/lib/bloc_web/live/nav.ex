defmodule BlocWeb.Nav do
  import Phoenix.LiveView
  use Phoenix.Component

  alias BlocWeb.TodayLive
  alias BlocWeb.HabitLive.Index, as: HabitLiveIndex
  alias BlocWeb.HabitLive.Show, as: HabitLiveShow
  alias BlocWeb.TaskLive.Index, as: TaskLiveIndex
  alias BlocWeb.TaskLive.Show, as: TaskLiveShow

  def on_mount(:default, _params, _session, socket) do
    {:cont,
     socket
     |> attach_hook(:active_tab, :handle_params, &handle_active_tab_params/3)}
  end

  defp handle_active_tab_params(_params, _url, socket) do
    active_tab =
      case {socket.view, socket.assigns.live_action} do
        {TodayLive, _} ->
          :today

        {HabitLiveIndex, _} ->
          :habits

        {HabitLiveShow, _} ->
          :habits

        {TaskLiveIndex, _} ->
          :tasks

        {TaskLiveShow, _} ->
          :tasks

        {_, _} ->
          nil
      end

    {:cont, assign(socket, active_tab: active_tab)}
  end
end
