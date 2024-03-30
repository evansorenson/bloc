defmodule BlocWeb.HabitPeriodLive.FormComponent do
  use BlocWeb, :live_component

  alias Bloc.Habits

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage habit_period records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="habit_period-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:period_type]}
          type="select"
          label="Period type"
          prompt="Choose a value"
          options={Ecto.Enum.values(Bloc.Habits.HabitPeriod, :period_type)}
        />
        <.input field={@form[:value]} type="number" label="Value" />
        <.input field={@form[:goal]} type="number" label="Goal" />
        <.input field={@form[:is_complete]} type="datetime-local" label="Is complete" />
        <.input field={@form[:is_active]} type="datetime-local" label="Is active" />
        <.input
          field={@form[:unit]}
          type="select"
          label="Unit"
          prompt="Choose a value"
          options={Ecto.Enum.values(Bloc.Habits.HabitPeriod, :unit)}
        />
        <.input field={@form[:date]} type="date" label="Date" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Habit period</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{habit_period: habit_period} = assigns, socket) do
    changeset = Habits.change_habit_period(habit_period)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"habit_period" => habit_period_params}, socket) do
    changeset =
      socket.assigns.habit_period
      |> Habits.change_habit_period(habit_period_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"habit_period" => habit_period_params}, socket) do
    save_habit_period(socket, socket.assigns.action, habit_period_params)
  end

  defp save_habit_period(socket, :edit, habit_period_params) do
    case Habits.update_habit_period(socket.assigns.habit_period, habit_period_params) do
      {:ok, habit_period} ->
        notify_parent({:saved, habit_period})

        {:noreply,
         socket
         |> put_flash(:info, "Habit period updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_habit_period(socket, :new, habit_period_params) do
    case Habits.create_habit_period(habit_period_params) do
      {:ok, habit_period} ->
        notify_parent({:saved, habit_period})

        {:noreply,
         socket
         |> put_flash(:info, "Habit period created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
