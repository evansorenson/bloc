defmodule BlocWeb.BlockLive.BlockComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Blocks.Block
  alias Bloc.Scope

  attr(:block, Block, required: true)
  attr(:id, :string, required: true)
  attr(:scope, Scope, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <li
      id={@id}
      style={"grid-row: #{@start} / span #{@span};"}
      class="draggable h-full relative flex flex-col text-xs ml-1 mr-2 drag-ghost:opacity-100 z-30 "
    >
      <div
        id={"#{@id}-resize-up"}
        class="h-0.5 top-0 bg-none cursor-n-resize"
        draggable="true"
        data-id={@block.id}
        ondragstart="dragStart(event)"
        data-event="resize_up"
      />
      <div
        id={"#{@id}-resize-down"}
        class="h-0.5 bottom-0 bg-none cursor-s-resize order-last"
        draggable="true"
        data-id={@block.id}
        ondragstart="dragStart(event)"
        data-event="resize_down"
      />
      <div
        style={"max-height: #{@span * 6}px;"}
        class="group h-full overflow-clip flex flex-col px-2 pt-1 rounded-lg bg-blue-50 hover:bg-blue-100"
        data-id={@block.id}
        draggable="true"
        ondragstart="dragStart(event)"
        data-event="move_block"
      >
        <p class="font-semibold text-blue-700 order-1"><%= @block.title %></p>

        <p class="text-blue-500 group-hover:text-blue-700">
          <%= TimeUtils.block_datetime_string(@scope, @block.start_time, :start) %> → <%= TimeUtils.block_datetime_string(
            @scope,
            @block.end_time,
            :end
          ) %>
        </p>

        <div class="sr-only">
          <.link navigate={~p"/blocks/#{@block.id}"}>Show</.link>
        </div>

        <div class="absolute top-2 right-2 text-left hidden">
          <div class="">
            <button
              type="button"
              class="flex items-center rounded-full bg-gray-100 text-gray-400 hover:text-gray-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-100 hover:bg-blue-100 "
              aria-expanded="true"
              aria-haspopup="true"
            >
              <span class="sr-only">Open options</span>
              <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path d="M10 3a1.5 1.5 0 110 3 1.5 1.5 0 010-3zM10 8.5a1.5 1.5 0 110 3 1.5 1.5 0 010-3zM11.5 15.5a1.5 1.5 0 10-3 0 1.5 1.5 0 003 0z" />
              </svg>
            </button>
          </div>
          <!--
    Dropdown menu, show/hide based on menu state.

    Entering: "transition ease-out duration-100"
      From: "transform opacity-0 scale-95"
      To: "transform opacity-100 scale-100"
    Leaving: "transition ease-in duration-75"
      From: "transform opacity-100 scale-100"
      To: "transform opacity-0 scale-95"
    -->
          <div
            class="absolute right-0 z-10 mt-2 w-56 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none hidden"
            role="menu"
            aria-orientation="vertical"
            aria-labelledby="menu-button"
            tabindex="-1"
          >
            <div class="py-1" role="none">
              <!-- Active: "bg-gray-100 text-gray-900", Not Active: "text-gray-700" -->
              <a
                href="#"
                class="text-gray-700 group flex items-center px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
              >
                <%!-- <.link patch={~p"/blocks/#{block}/edit"}>Edit</.link> --%>
                <svg
                  class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path d="M5.433 13.917l1.262-3.155A4 4 0 017.58 9.42l6.92-6.918a2.121 2.121 0 013 3l-6.92 6.918c-.383.383-.84.685-1.343.886l-3.154 1.262a.5.5 0 01-.65-.65z" />
                  <path d="M3.5 5.75c0-.69.56-1.25 1.25-1.25H10A.75.75 0 0010 3H4.75A2.75 2.75 0 002 5.75v9.5A2.75 2.75 0 004.75 18h9.5A2.75 2.75 0 0017 15.25V10a.75.75 0 00-1.5 0v5.25c0 .69-.56 1.25-1.25 1.25h-9.5c-.69 0-1.25-.56-1.25-1.25v-9.5z" />
                </svg>
                Edit
              </a>
              <a
                href="#"
                class="text-gray-700 group flex items-center px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
              >
                <svg
                  class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path d="M7 3.5A1.5 1.5 0 018.5 2h3.879a1.5 1.5 0 011.06.44l3.122 3.12A1.5 1.5 0 0117 6.622V12.5a1.5 1.5 0 01-1.5 1.5h-1v-3.379a3 3 0 00-.879-2.121L10.5 5.379A3 3 0 008.379 4.5H7v-1z" />
                  <path d="M4.5 6A1.5 1.5 0 003 7.5v9A1.5 1.5 0 004.5 18h7a1.5 1.5 0 001.5-1.5v-5.879a1.5 1.5 0 00-.44-1.06L9.44 6.439A1.5 1.5 0 008.378 6H4.5z" />
                </svg>
                Duplicate
              </a>
            </div>
            <div class="py-1" role="none">
              <a
                href="#"
                class="text-gray-700 group flex items-center px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
              >
                <svg
                  class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path d="M2 3a1 1 0 00-1 1v1a1 1 0 001 1h16a1 1 0 001-1V4a1 1 0 00-1-1H2z" />
                  <path
                    fill-rule="evenodd"
                    d="M2 7.5h16l-.811 7.71a2 2 0 01-1.99 1.79H4.802a2 2 0 01-1.99-1.79L2 7.5zM7 11a1 1 0 011-1h4a1 1 0 110 2H8a1 1 0 01-1-1z"
                    clip-rule="evenodd"
                  />
                </svg>
                Archive
              </a>
              <a
                href="#"
                class="text-gray-700 group flex items-center px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
              >
                <svg
                  class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path
                    fill-rule="evenodd"
                    d="M10 18a8 8 0 100-16 8 8 0 000 16zM6.75 9.25a.75.75 0 000 1.5h4.59l-2.1 1.95a.75.75 0 001.02 1.1l3.5-3.25a.75.75 0 000-1.1l-3.5-3.25a.75.75 0 10-1.02 1.1l2.1 1.95H6.75z"
                    clip-rule="evenodd"
                  />
                </svg>
                Move
              </a>
            </div>
            <div class="py-1" role="none">
              <a
                href="#"
                class="text-gray-700 group flex items-center px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
              >
                <svg
                  class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path d="M11 5a3 3 0 11-6 0 3 3 0 016 0zM2.615 16.428a1.224 1.224 0 01-.569-1.175 6.002 6.002 0 0111.908 0c.058.467-.172.92-.57 1.174A9.953 9.953 0 018 18a9.953 9.953 0 01-5.385-1.572zM16.25 5.75a.75.75 0 00-1.5 0v2h-2a.75.75 0 000 1.5h2v2a.75.75 0 001.5 0v-2h2a.75.75 0 000-1.5h-2v-2z" />
                </svg>
                Share
              </a>
              <a
                href="#"
                class="text-gray-700 group flex items-center px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
              >
                <svg
                  class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path d="M9.653 16.915l-.005-.003-.019-.01a20.759 20.759 0 01-1.162-.682 22.045 22.045 0 01-2.582-1.9C4.045 12.733 2 10.352 2 7.5a4.5 4.5 0 018-2.828A4.5 4.5 0 0118 7.5c0 2.852-2.044 5.233-3.885 6.82a22.049 22.049 0 01-3.744 2.582l-.019.01-.005.003h-.002a.739.739 0 01-.69.001l-.002-.001z" />
                </svg>
                Add to favorites
              </a>
            </div>
            <div
              class="py-1"
              role="none"
              phx-click={JS.push("delete", value: %{id: @block.id}) |> hide("##{@id}")}
              data-confirm="Are you sure?"
            >
              <a
                href="#"
                class="text-gray-700 group flex items-center px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
              >
                <svg
                  class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path
                    fill-rule="evenodd"
                    d="M8.75 1A2.75 2.75 0 006 3.75v.443c-.795.077-1.584.176-2.365.298a.75.75 0 10.23 1.482l.149-.022.841 10.518A2.75 2.75 0 007.596 19h4.807a2.75 2.75 0 002.742-2.53l.841-10.52.149.023a.75.75 0 00.23-1.482A41.03 41.03 0 0014 4.193V3.75A2.75 2.75 0 0011.25 1h-2.5zM10 4c.84 0 1.673.025 2.5.075V3.75c0-.69-.56-1.25-1.25-1.25h-2.5c-.69 0-1.25.56-1.25 1.25v.325C8.327 4.025 9.16 4 10 4zM8.58 7.72a.75.75 0 00-1.5.06l.3 7.5a.75.75 0 101.5-.06l-.3-7.5zm4.34.06a.75.75 0 10-1.5-.06l-.3 7.5a.75.75 0 101.5.06l.3-7.5z"
                    clip-rule="evenodd"
                  />
                </svg>
                Delete
              </a>
            </div>
          </div>
        </div>
      </div>
    </li>
    """
  end

  @impl true
  def update(%{block: block} = assigns, socket) do
    span =
      trunc(DateTime.diff(block.end_time, block.start_time, :minute) / 5)

    local_start_time = Timex.Timezone.convert(block.start_time, assigns.scope.timezone)

    start =
      trunc((local_start_time.minute + 10 + local_start_time.hour * 60) / 5)

    {:ok, socket |> assign(assigns) |> assign(:span, span) |> assign(:start, start)}
  end

  @impl true
  def handle_event("reposition", %{"id" => _id, "new" => _new_position, "old" => _old_position}, socket) do
    # task = Tasks.get_task!(id)
    # {:noreply, socket |> stream_insert(:tasks, task, at: new_position)}
    {:noreply, socket}
  end
end
