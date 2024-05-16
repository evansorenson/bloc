defmodule BlocWeb.DayTaskList do
  use BlocWeb, :live_component

  alias Bloc.Tasks

  attr(:day, Date, required: true)
  attr(:scope, Bloc.Scope, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full flex">
      <div class="flex-none w-96 px-4 py-4 sm:px-6 md:overflow-y-auto md:border-l md:border-gray-200 md:py-6 md:px-8 md:block">
        <.header>
          <%= Calendar.strftime(@day, "%A") %>
          <h2><%= Calendar.strftime(@day, "%B %d") %></h2>
          <:actions>
            <.button>New Task</.button>
          </:actions>
        </.header>

        <div class="flex flex-col mt-4">
          <%= for {id, task} <- @streams.tasks do %>
            <.live_component
              module={BlocWeb.TaskLive.TaskComponent}
              id={id}
              task={task}
              scope={@scope}
            />
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    socket
    |> assign(assigns)
    |> stream(
      :tasks,
      Tasks.list_tasks(assigns.scope,
        order_by: [{:desc, :complete?}, {:asc, :due_date}]
      )
    )
    |> Tuples.ok()
  end
end
