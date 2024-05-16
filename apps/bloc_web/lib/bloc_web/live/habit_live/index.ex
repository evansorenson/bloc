defmodule BlocWeb.HabitLive.Index do
  @moduledoc false
  use BlocWeb, :live_view

  alias Bloc.Habits
  alias Bloc.Habits.Habit

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})

  @impl true
  def mount(_params, _session, socket) do
    all_periods = Habit |> Ecto.Enum.values(:period_type) |> IO.inspect(label: "all_periods")
    all_habits = Habits.list_habits(socket.assigns.current_user)

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

    {:noreply, stream_delete(socket, habit.period_type, habit)}
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
end
