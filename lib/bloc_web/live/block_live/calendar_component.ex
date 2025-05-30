defmodule BlocWeb.CalendarComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Blocks
  alias Bloc.Blocks.Block
  alias Bloc.Scope
  alias Bloc.Tasks

  require Logger

  attr(:day, Date, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div id="" class="h-screen flex flex-col w-60">
        <header class="items-center justify-between px-6 py-4 flex flex-none border-b border-gray-200">
          <div class="items-center flex w-full justify-between">
            <div class="inline-flex rounded-md shadow-sm">
              <button
                type="button"
                class="relative inline-flex items-center rounded-l-md bg-white px-2 py-1 text-xs font-normal text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-10"
              >
                Calendars
              </button>
              <div class="relative -ml-px block">
                <button
                  type="button"
                  class="relative inline-flex items-center rounded-r-md bg-white px-1 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-10"
                  id="option-menu-button"
                  aria-expanded="true"
                  aria-haspopup="true"
                >
                  <span class="sr-only">Open options</span>
                  <svg class="h-3 w-3" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path
                      fill-rule="evenodd"
                      d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z"
                      clip-rule="evenodd"
                    />
                  </svg>
                </button>
                <!--
      Dropdown menu, show/hide based on menu state.

      Entering: "transition ease-out duration-100"
        From: "transform opacity-0 scale-95"
        To: "transform opacity-100 scale-100"
      Leaving: "transition ease-in duration-75"
        From: "transform opacity-100 scale-100"
        To: "transform opacity-0 scale-95"
    -->
                <%!-- <div
            class="absolute right-0 z-10 -mr-1 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
            role="menu"
            aria-orientation="vertical"
            aria-labelledby="option-menu-button"
            tabindex="-1"
          >
            <div class="py-1" role="none">
              <!-- Active: "bg-gray-100 text-gray-900", Not Active: "text-gray-700" -->
              <a
                href="#"
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="option-menu-item-0"
              >
                Save and schedule
              </a>
              <a
                href="#"
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="option-menu-item-1"
              >
                Save and publish
              </a>
              <a
                href="#"
                class="text-gray-700 block px-4 py-2 text-sm"
                role="menuitem"
                tabindex="-1"
                id="option-menu-item-2"
              >
                Export PDF
              </a>
            </div>
          </div> --%>
              </div>
            </div>
            <span class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-gray-400 shadow-md">
              <span class="text-sm font-medium leading-none text-white">ES</span>
            </span>
          </div>
        </header>
        <div class="bg-white isolate flex flex-auto overflow-hidden">
          <div class="flex flex-auto flex-col overflow-auto">
            <div class="w-full flex flex-auto">
              <div class="w-14 bg-white flex-none ring-1 ring-gray-100"></div>
              <div id="day-grid" class="grid flex-auto grid-cols-1 grid-rows-1">
                <div
                  style="grid-template-rows: repeat(36, minmax(2.0rem, 1fr));"
                  class="col-start-1 col-end-2 row-start-1
                  grid divide-y divide-gray-100"
                >
                  <div class="row-end-1 h-7"></div>
                  <%= for hour <- ["6AM", "7AM", "8AM", "9AM", "10AM", "11AM", "12PM", "1PM", "2PM", "3PM", "4PM", "5PM", "6PM", "7PM", "8PM", "9PM", "10PM", "11PM"] do %>
                    <div>
                      <div class="-ml-14 -mt-2.5 w-14 pr-2 text-right text-xs leading-5 text-gray-400">
                        <%= hour %>
                      </div>
                    </div>
                    <div></div>
                  <% end %>
                </div>
                <ul
                  style="grid-template-rows: 1.00rem repeat(288, minmax(0px, 1fr)) auto;"
                  class="droppable-container col-start-1 col-end-2
                  row-start-1 grid grid-cols-1"
                  id="window-list"
                >
                  <li class="static row-span-1" />
                  <%!-- Dropzones - 15 minute windows for 18 hours --%>
                  <%= for window <- 1..(18 * 4) do %>
                    <li
                      class="dropzone relative flex bg-none row-span-3"
                      id={"block-#{window}"}
                      data-id={window}
                      phx-value-window={window}
                      phx-hook="Droppable"
                    />
                  <% end %>
                </ul>
                <ul
                  style="grid-template-rows: 1.00rem repeat(288, minmax(0px, 1fr)) auto;"
                  class="droppable-container col-start-1 col-end-2
                  row-start-1 grid grid-cols-auto"
                  phx-update="stream"
                  id="block-list-2"
                >
                  <%= for {id, block}  <- @streams.blocks do %>
                    <.live_component
                      module={BlocWeb.BlockLive.BlockComponent}
                      id={id}
                      block={block}
                      scope={@scope}
                    />
                  <% end %>
                  <%!-- row_click={fn {_id, block} -> JS.navigate(~p"/blocks/#{block}") end} --%>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>

      <%!-- <.table
              id="blocks"
              rows={@streams.blocks}
              row_click={fn {_id, block} -> JS.navigate(~p"/blocks/#{block}") end}
            >
              <:col :let={{_id, block}} label="Title"><%= block.title %></:col>
              <:col :let={{_id, block}} label="Start time"><%= block.start_time %></:col>
              <:col :let={{_id, block}} label="End time"><%= block.end_time %></:col>
              <:action :let={{_id, block}}>
                <div class="sr-only">
                  <.link navigate={~p"/blocks/#{block}"}>Show</.link>
                </div>
                <.link patch={~p"/blocks/#{block}/edit"}>Edit</.link>
              </:action>
              <:action :let={{id, block}}>
                <.link
                  phx-click={JS.push("delete", value: %{id: block.id}) |> hide("##{id}")}
                  data-confirm="Are you sure?"
                >
                  Delete
                </.link>
              </:action>
            </.table> --%>

      <.modal :if={@live_action in [:new, :edit]} id="block-modal" show on_cancel={JS.push("cancel")}>
        <.live_component
          module={BlocWeb.BlockLive.FormComponent}
          id={@block.id || :new}
          title={@page_title}
          action={@live_action}
          block={@block}
          scope={@scope}
        />
      </.modal>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    socket
    |> assign(assigns)
    |> stream(:blocks, Blocks.blocks_for_day(assigns.scope))
    |> apply_action(:index, %{})
    |> Tuples.ok()
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Block")
    |> assign(:live_action, :edit)
    |> assign(:block, Blocks.get_block!(id))
  end

  defp apply_action(socket, :new, _params) do
    first_available_time =
      socket.assigns.scope |> Blocks.blocks_for_day() |> Blocks.first_available_time()

    socket
    |> assign(:page_title, "New Block")
    |> assign(:live_action, :new)
    |> assign(:block, %Block{
      start_time: first_available_time,
      end_time: DateTime.add(first_available_time, 1, :hour)
    })
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Blocks")
    |> assign(:live_action, :index)
    |> assign(:block, nil)
  end

  # @impl true
  # def handle_info({BlocWeb.BlockLive.FormComponent, {:saved, block}}, socket) do
  #   {:noreply, socket |> stream_insert(:blocks, block) |> apply_action(:index, %{})}
  # end

  @impl true
  def handle_event("new", _params, socket) do
    {:noreply, apply_action(socket, :new, %{})}
  end

  def handle_event("cancel", _params, socket) do
    {:noreply, apply_action(socket, :index, %{})}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    block = Blocks.get_block!(id)
    {:ok, _} = Blocks.delete_block(block)

    {:noreply, stream_delete(socket, :blocks, block)}
  end

  def handle_event("reposition", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("add_block", %{"id" => task_id, "window" => window}, socket) do
    start_time = window_to_date_time(socket.assigns.scope, window, socket.assigns.day)

    task = Tasks.get_task!(task_id)
    end_time = DateTime.add(start_time, task.estimated_minutes || 30, :minute)

    case Blocks.create_block(%{
           start_time: start_time,
           end_time: end_time,
           title: task.title,
           task_id: task_id,
           user_id: socket.assigns.scope.current_user.id
         }) do
      {:ok, block} ->
        send(socket.parent_pid, {__MODULE__, {:task_scheduled, %{task: task, block: block}}})
        {:noreply, stream_insert(socket, :blocks, block)}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Failed to create block")}
    end
  end

  def handle_event("move_block", %{"id" => block_id, "window" => window}, socket) do
    start_time = window_to_date_time(socket.assigns.scope, window, socket.assigns.day)

    block = Blocks.get_block!(block_id)
    diff = DateTime.diff(block.end_time, block.start_time, :minute)
    end_time = DateTime.add(start_time, diff, :minute)

    update_block(socket, block_id, %{start_time: start_time, end_time: end_time})
  end

  def handle_event("resize_up", %{"id" => block_id, "window" => window}, socket) do
    update_block(socket, block_id, %{
      start_time: window_to_date_time(socket.assigns.scope, window, socket.assigns.day)
    })
  end

  def handle_event("resize_down", %{"id" => block_id, "window" => window}, socket) do
    update_block(socket, block_id, %{
      end_time: window_to_date_time(socket.assigns.scope, window + 1, socket.assigns.day)
    })
  end

  defp update_block(socket, block_id, params) do
    block_id
    |> Blocks.get_block!()
    |> Blocks.update_block(params)
    |> case do
      {:ok, block} ->
        {:noreply, stream_insert(socket, :blocks, block)}

      {:error, changeset} ->
        Logger.error("Failed to update block - #{inspect(changeset)}",
          block_id: block_id,
          params: params
        )

        {:noreply, put_flash(socket, :error, "Failed to update block")}
    end
  end

  defp window_to_date_time(%Scope{timezone: timezone}, window, day) do
    window = window - 1
    time_from_minutes = Time.from_seconds_after_midnight((window * 15 + 360) * 60)

    day
    |> DateTime.new!(time_from_minutes, timezone)
    |> Timex.Timezone.convert("UTC")
  end
end
