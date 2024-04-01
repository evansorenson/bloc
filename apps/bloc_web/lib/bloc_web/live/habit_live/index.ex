defmodule BlocWeb.HabitLive.Index do
  alias Bloc.Habits.HabitPeriod
  use BlocWeb, :live_view

  alias Bloc.Habits
  alias Bloc.Habits.Habit
  alias Bloc.Repo

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})

  @impl true
  def mount(params, session, socket) do
    IO.inspect(params)
    IO.inspect(session)

    {:ok,
     stream(
       socket,
       :habit_periods,
       Habits.list_habit_periods(socket.assigns.current_user, where: [{:active?, :ne, nil}])
     )}
  end

  # @impl true
  # def handle_params(params, _url, socket) do
  #   {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  # end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Habit Period")
    |> assign(:habit, Habits.get_habit!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Habit")
    |> assign(:live_action, :new)
    |> assign(:habit, %Habit{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Habit Period")
    |> assign(:habit, nil)
  end

  @impl true
  def handle_info({BlocWeb.HabitLive.FormComponent, {:saved, habit}}, socket) do
    [habit_period] =
      Habits.list_habit_periods(socket.assigns.current_user,
        where: [{:habit_id, habit.id}, {:active?, :ne, nil}]
      )

    {:noreply, stream_insert(socket, :habit_periods, habit_period)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    habit = Habits.get_habit!(id)
    {:ok, _habit} = Habits.delete_habit(habit)

    habit_period =
      Habits.list_habit_periods(socket.assigns.current_user,
        where: [{:habit_id, id}, {:active?, :ne, nil}]
      )

    {:noreply, stream_delete(socket, :habit_periods, habit_period)}
  end

  def handle_event("new", _unsigned_params, socket) do
    {:noreply, apply_action(socket, :new, %{})}
  end

  def handle_event("cancel", unsigned_params, socket) do
    {:noreply, apply_action(socket, :index, unsigned_params)}
  end
end
