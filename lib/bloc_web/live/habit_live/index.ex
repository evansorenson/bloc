defmodule BlocWeb.HabitLive.Index do
  @moduledoc false
  use BlocWeb, :live_view

  alias Bloc.Habits
  alias Bloc.Habits.Habit
  alias Bloc.Habits.HabitDay
  alias Bloc.Scope

  require Logger

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})

  @impl true
  def mount(_params, _session, socket) do
    scope = socket.assigns.scope
    all_periods = Ecto.Enum.values(Habit, :period_type)
    all_habits = Habits.list_habits(scope)

    today = TimeUtils.today(scope)
    start_of_week = Date.beginning_of_week(today)

    socket =
      socket
      |> assign(:current_week_start, start_of_week)
      |> assign(:habit_days, list_habit_days(scope, start_of_week))
      |> assign(:delete_confirmation, nil)

    socket =
      Enum.reduce(all_periods, socket, fn period, socket ->
        all_habits
        |> Enum.filter(&(&1.period_type == period))
        |> then(&stream(socket, period, &1))
      end)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Habit")
    |> assign(:habit, Habits.get_habit!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Habit")
    |> assign(:habit, %Habit{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Habit")
    |> assign(:habit, nil)
  end

  @impl true
  def handle_info({BlocWeb.HabitLive.FormComponent, {:saved, %Habit{} = habit}}, socket) do
    {:noreply, socket |> stream_insert(habit.period_type, habit) |> assign(:live_action, :index)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    %Habit{} = habit = Habits.get_habit!(id)
    {:ok, _habit} = Habits.delete_habit(habit)

    {:noreply,
     socket
     |> stream_delete(habit.period_type, habit)
     |> assign(:delete_confirmation, nil)
     |> put_flash(:info, "Habit deleted successfully")}
  end

  def handle_event("new", _unsigned_params, socket) do
    {:noreply, apply_action(socket, :new, %{})}
  end

  def handle_event("edit", %{"id" => id}, socket) do
    {:noreply, apply_action(socket, :edit, %{"id" => id})}
  end

  def handle_event("cancel", unsigned_params, socket) do
    {:noreply, apply_action(socket, :index, unsigned_params)}
  end

  @impl true
  def handle_event("confirm_delete", %{"id" => id}, socket) do
    {:noreply, assign(socket, :delete_confirmation, id)}
  end

  @impl true
  def handle_event("cancel_delete", _, socket) do
    {:noreply, assign(socket, :delete_confirmation, nil)}
  end

  @impl true
  def handle_event("prev-week", _, socket) do
    new_week = Date.add(socket.assigns.current_week_start, -7)
    {:noreply, assign(socket, current_week_start: new_week, habit_days: list_habit_days(socket.assigns.scope, new_week))}
  end

  def handle_event("next-week", _, socket) do
    new_week = Date.add(socket.assigns.current_week_start, 7)
    {:noreply, assign(socket, current_week_start: new_week, habit_days: list_habit_days(socket.assigns.scope, new_week))}
  end

  @spec list_habit_days(scope :: Scope.t(), start_of_week :: Date.t()) :: [
          {habit_id :: integer(), [habit_day :: %HabitDay{}]}
        ]
  defp list_habit_days(%Scope{} = scope, start_of_week) do
    end_of_week = Date.end_of_week(start_of_week)

    habit_days =
      scope
      |> Habits.list_habit_days(start_of_week, end_of_week, preload: [:habit])
      |> Map.new(fn habit_day -> {{habit_day.habit_id, habit_day.date}, habit_day} end)

    scope
    |> Habits.list_habits(period_type: :daily, parent_id: :none)
    |> Enum.map(fn habit ->
      habit_days =
        start_of_week
        |> Date.range(end_of_week)
        |> Enum.map(fn date -> Map.get(habit_days, {habit.id, date}, %{completed?: false, date: date}) end)

      {habit, habit_days}
    end)
  end
end
