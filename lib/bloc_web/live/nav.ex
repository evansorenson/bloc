defmodule BlocWeb.Nav do
  @moduledoc false
  use Phoenix.Component

  import Phoenix.LiveView

  alias BlocWeb.HabitLive.Index, as: HabitLiveIndex
  alias BlocWeb.HabitLive.Show, as: HabitLiveShow
  alias BlocWeb.TaskLive.Index, as: TaskLiveIndex
  alias BlocWeb.TaskLive.Show, as: TaskLiveShow
  alias BlocWeb.TodayLive
  alias BlocWeb.RewardLive.Index, as: RewardLiveIndex

  def on_mount(:default, _params, _session, socket) do
    {:cont, attach_hook(socket, :active_tab, :handle_params, &handle_active_tab_params/3)}
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

        {RewardLiveIndex, _} ->
          :rewards

        {_, _} ->
          nil
      end

    {:cont, assign(socket, active_tab: active_tab)}
  end
end
