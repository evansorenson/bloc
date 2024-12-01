defmodule BlocWeb.HabitLive.FormComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Habits
  alias Bloc.Scope

  attr(:scope, Scope, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white rounded-lg">
      <div class="px-6 py-4 border-b border-gray-100">
        <div class="flex items-center">
          <%= case @action do %>
            <% :new -> %>
              <div class="bg-indigo-100 p-2 rounded-lg mr-3">
                <.icon name="hero-plus" class="h-5 w-5 text-indigo-600" />
              </div>
            <% :edit -> %>
              <div class="bg-blue-100 p-2 rounded-lg mr-3">
                <.icon name="hero-pencil" class="h-5 w-5 text-blue-600" />
              </div>
          <% end %>
          <div>
            <h2 class="text-xl font-semibold text-gray-900"><%= @title %></h2>
            <p class="mt-1 text-sm text-gray-500">Create and manage your recurring habits</p>
          </div>
        </div>
      </div>

      <.simple_form
        for={@form}
        id="habit-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
        class="p-6 space-y-6"
      >
        <div class="space-y-4">
          <div>
            <.input
              field={@form[:title]}
              type="text"
              label="Title"
              placeholder="e.g. Morning Meditation"
              class="rounded-lg"
            />
          </div>

          <div>
            <.input
              field={@form[:notes]}
              type="text"
              label="Notes (optional)"
              placeholder="Add any additional details"
              class="rounded-lg"
            />
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <.input
                field={@form[:period_type]}
                type="select"
                label="Repeat"
                prompt="Choose frequency"
                options={[
                  {"🌅 Daily", :daily},
                  {"📅 Weekly", :weekly},
                  {"🗓️ Monthly", :monthly}
                ]}
                class="rounded-lg"
              />
            </div>

            <div class="flex gap-4">
              <div class="flex-1">
                <.input field={@form[:start_time]} type="time" label="Start time" class="rounded-lg" />
              </div>
              <div class="flex-1">
                <.input field={@form[:end_time]} type="time" label="End time" class="rounded-lg" />
              </div>
            </div>
          </div>

          <div>
            <.input
              field={@form[:required_count]}
              type="number"
              label="Count"
              min="1"
              class="rounded-lg"
            />
          </div>
        </div>

        <div class="pt-4 border-t border-gray-100">
          <.button
            phx-disable-with="Saving..."
            class="w-full bg-indigo-600 hover:bg-indigo-500 rounded-lg"
          >
            <%= if @action == :new, do: "Create Habit", else: "Save Changes" %>
          </.button>
        </div>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{habit: habit} = assigns, socket) do
    changeset = Habits.change_update_habit(habit)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"habit" => habit_params}, socket) do
    habit_params = Map.put(habit_params, "user_id", socket.assigns.scope.current_user_id)

    changeset =
      socket.assigns.habit
      |> Habits.change_update_habit(habit_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"habit" => habit_params}, socket) do
    save_habit(socket, socket.assigns.action, habit_params)
  end

  defp save_habit(socket, :edit, habit_params) do
    # TOOO: fix habit time based on user zone
    case Habits.update_habit(socket.assigns.habit, habit_params, socket.assigns.scope) do
      {:ok, habit} ->
        notify_parent({:saved, habit})

        {:noreply,
         socket
         |> put_flash!(:info, "Habit updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_habit(socket, :new, habit_params) do
    habit_params
    |> Map.put("user_id", socket.assigns.scope.current_user_id)
    |> Habits.create_habit()
    |> case do
      {:ok, habit} ->
        notify_parent({:saved, habit})

        {:noreply,
         socket
         |> put_flash!(:info, "Habit created successfully")
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
