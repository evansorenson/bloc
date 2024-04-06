defmodule BlocWeb.HabitLive.Index do
  use BlocWeb, :live_view

  alias Bloc.Habits
  alias Bloc.Habits.Habit
  alias Bloc.Utils.Ok

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> stream(
      :daily_habits,
      Habits.list_habits(socket.assigns.current_user, where: [period_type: :daily])
    )
    |> stream(
      :weekly_habits,
      Habits.list_habits(socket.assigns.current_user, where: [period_type: :weekly])
    )
    |> stream(
      :monthly_habits,
      Habits.list_habits(socket.assigns.current_user, where: [period_type: :monthly])
    )
    |> Ok.wrap()
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
  def handle_info({BlocWeb.HabitLive.FormComponent, {:saved, habit}}, socket) do
    {:noreply,
     stream_insert(socket, list_for_period(habit), habit) |> assign(:live_action, :index)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    habit = Habits.get_habit!(id)
    {:ok, _habit} = Habits.delete_habit(habit)

    {:noreply, stream_delete(socket, list_for_period(habit), habit)}
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

  defp list_for_period(%Habit{period_type: :daily}), do: :daily_habits
  defp list_for_period(%Habit{period_type: :weekly}), do: :weekly_habits
  defp list_for_period(%Habit{period_type: :monthly}), do: :monthly_habits
end
