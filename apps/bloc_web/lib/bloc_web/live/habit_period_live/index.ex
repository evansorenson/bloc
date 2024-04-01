defmodule BlocWeb.HabitPeriodLive.Index do
  use BlocWeb, :live_view

  alias Bloc.Habits
  alias Bloc.Habits.HabitPeriod

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     stream(
       socket,
       :habit_periods,
       Habits.list_habit_periods(socket.assigns.current_user, where: [{:active?, :ne, nil}])
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Habit period")
    |> assign(:habit_period, Habits.get_habit_period!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Habit period")
    |> assign(:habit_period, %HabitPeriod{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Habit periods")
    |> assign(:habit_period, nil)
  end

  @impl true
  def handle_info({BlocWeb.HabitPeriodLive.FormComponent, {:saved, habit_period}}, socket) do
    {:noreply, stream_insert(socket, :habit_periods, habit_period)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    habit_period = Habits.get_habit_period!(id)
    {:ok, _} = Habits.delete_habit_period(habit_period)

    {:noreply, stream_delete(socket, :habit_periods, habit_period)}
  end
end
