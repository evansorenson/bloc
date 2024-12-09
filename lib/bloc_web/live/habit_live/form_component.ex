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

          <div :if={@form[:period_type].value != :monthly} class="mt-4">
            <label class="block text-sm font-medium text-gray-700">Days of Week</label>
            <div class="mt-2 flex flex-wrap gap-2">
              <label class="inline-flex items-center">
                <input
                  type="checkbox"
                  name="habit[days][]"
                  value="1"
                  checked={1 in (@form[:days].value || [])}
                  class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                />
                <span class="ml-2 text-sm text-gray-600">Mon</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="checkbox"
                  name="habit[days][]"
                  value="2"
                  checked={2 in (@form[:days].value || [])}
                  class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                />
                <span class="ml-2 text-sm text-gray-600">Tue</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="checkbox"
                  name="habit[days][]"
                  value="3"
                  checked={3 in (@form[:days].value || [])}
                  class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                />
                <span class="ml-2 text-sm text-gray-600">Wed</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="checkbox"
                  name="habit[days][]"
                  value="4"
                  checked={4 in (@form[:days].value || [])}
                  class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                />
                <span class="ml-2 text-sm text-gray-600">Thu</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="checkbox"
                  name="habit[days][]"
                  value="5"
                  checked={5 in (@form[:days].value || [])}
                  class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                />
                <span class="ml-2 text-sm text-gray-600">Fri</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="checkbox"
                  name="habit[days][]"
                  value="6"
                  checked={6 in (@form[:days].value || [])}
                  class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                />
                <span class="ml-2 text-sm text-gray-600">Sat</span>
              </label>
              <label class="inline-flex items-center">
                <input
                  type="checkbox"
                  name="habit[days][]"
                  value="7"
                  checked={7 in (@form[:days].value || [])}
                  class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
                />
                <span class="ml-2 text-sm text-gray-600">Sun</span>
              </label>
            </div>
          </div>
        </div>

        <div :if={is_nil(@habit.parent_id)} class="mt-6 border-t border-gray-100 pt-6">
          <div class="flex items-center justify-between mb-4">
            <div>
              <h3 class="text-sm font-medium text-gray-900">Sub-habits</h3>
              <p class="mt-1 text-sm text-gray-500">Break down your habit into smaller parts</p>
            </div>
          </div>

          <div class="mt-4 space-y-4">
            <%= for {subhabit, i} <- Enum.with_index(@subhabits) do %>
              <div class="flex items-center gap-4">
                <div class="flex-1">
                  <input
                    type="text"
                    name={"habit[subhabits][#{i}][title]"}
                    value={Map.get(subhabit, "title") || Map.get(subhabit, :title)}
                    placeholder="Sub-habit title"
                    class="block w-full rounded-lg border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
                    phx-keyup="update_subhabit"
                    phx-debounce="500"
                    phx-value-index={i}
                    phx-target={@myself}
                  />
                </div>
                <button
                  type="button"
                  phx-click="remove_subhabit"
                  phx-value-index={i}
                  phx-target={@myself}
                  class="p-2 text-gray-400 hover:text-gray-500"
                >
                  <.icon name="hero-x-mark" class="h-5 w-5" />
                </button>
              </div>
            <% end %>

            <button
              type="button"
              phx-click="add_subhabit"
              phx-target={@myself}
              class="mt-4 inline-flex items-center gap-2 text-sm text-indigo-600 hover:text-indigo-500"
            >
              <.icon name="hero-plus-circle" class="h-5 w-5" /> Add sub-habit
            </button>
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
  def mount(socket) do
    {:ok, assign(socket, subhabits: [])}
  end

  @impl true
  def update(%{habit: habit} = assigns, socket) do
    changeset = Habits.change_update_habit(habit)

    subhabits =
      if is_nil(habit.id) do
        []
      else
        Bloc.Repo.preload(habit, :subhabits).subhabits
      end

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:subhabits, subhabits)
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
    # Add subhabits to params if they exist
    habit_params = Map.put(habit_params, "subhabits", get_subhabits_params(socket))
    save_habit(socket, socket.assigns.action, habit_params)
  end

  def handle_event("add_subhabit", _params, socket) do
    subhabits = IO.inspect(socket.assigns.subhabits ++ [%{"title" => ""}])
    {:noreply, assign(socket, :subhabits, subhabits)}
  end

  def handle_event("remove_subhabit", %{"index" => index}, socket) do
    index = String.to_integer(index)
    subhabits = List.delete_at(socket.assigns.subhabits, index)
    {:noreply, assign(socket, :subhabits, subhabits)}
  end

  def handle_event("update_subhabit", %{"index" => index, "value" => title}, socket) do
    index = String.to_integer(index)
    subhabits = List.update_at(socket.assigns.subhabits, index, &Map.put(&1, "title", title))
    {:noreply, assign(socket, :subhabits, subhabits)}
  end

  defp get_subhabits_params(socket) do
    socket.assigns.subhabits
    |> Enum.reject(&(String.trim(Map.get(&1, "title")) == ""))
    |> Enum.map(&Map.take(&1, ["title"]))
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
    |> Habits.create_habit(socket.assigns.scope)
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
