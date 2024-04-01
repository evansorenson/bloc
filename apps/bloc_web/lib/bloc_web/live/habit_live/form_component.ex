defmodule BlocWeb.HabitLive.FormComponent do
  use BlocWeb, :live_component

  alias Bloc.Habits

  def on_mount(_params, socket) do
    {:ok, assign(socket, current_user: socket.assigns.current_user)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage habit records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="habit-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:notes]} type="text" label="Notes" />
        <.input
          field={@form[:period_type]}
          type="select"
          label="Period type"
          prompt="Choose a value"
          options={Ecto.Enum.values(Bloc.Habits.Habit, :period_type)}
        />
        <.input field={@form[:goal]} type="number" label="Goal" />
        <.input
          field={@form[:unit]}
          type="select"
          label="Unit"
          prompt="Choose a value"
          options={Ecto.Enum.values(Bloc.Habits.Habit, :unit)}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Habit</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{habit: habit} = assigns, socket) do
    changeset = Habits.change_habit(habit)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"habit" => habit_params}, socket) do
    habit_params = Map.put(habit_params, "user_id", socket.assigns.current_user.id)

    changeset =
      socket.assigns.habit
      |> Habits.change_habit(habit_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"habit" => habit_params}, socket) do
    save_habit(socket, socket.assigns.action, habit_params)
  end

  defp save_habit(socket, :edit, habit_params) do
    current_and_future_habit_periods =
      Habits.list_habit_periods(socket.assigns.current_user,
        where: [{:date, :gte, Date.utc_today()}]
      )
      |> Enum.map(
        &Habits.change_habit_period(&1, %{
          "goal" => habit_params["goal"],
          "unit" => habit_params["unit"],
          "period_type" => habit_params["period_type"],
          "complete?" => &1.value >= habit_params["goal"]
        })
      )

    habit_params = Map.put(habit_params, "habit_periods", current_and_future_habit_periods)

    case Habits.update_habit(socket.assigns.habit, habit_params) do
      {:ok, habit} ->
        notify_parent({:saved, habit})

        {:noreply,
         socket
         |> put_flash(:info, "Habit updated successfully")
         |> assign(:live_action, :index)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_habit(socket, :new, habit_params) do
    habit_params
    |> Map.put("user_id", socket.assigns.current_user.id)
    |> Habits.create_habit()
    |> case do
      {:ok, habit} ->
        notify_parent({:saved, habit})

        {:noreply,
         socket
         |> put_flash(:info, "Habit created successfully")
         |> assign(:live_action, :index)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
