defmodule BlocWeb.BlockLive.Index do
  require Logger
  alias Bloc.Scope
  alias Bloc.Tasks
  use BlocWeb, :live_view

  alias Bloc.Blocks
  alias Bloc.Blocks.Block

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})
  on_mount(BlocWeb.Scope)

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :blocks, Blocks.blocks_for_day(socket.assigns.scope))}
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
      end_time: first_available_time |> DateTime.add(1, :hour)
    })
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Blocks")
    |> assign(:live_action, :index)
    |> assign(:block, nil)
  end

  @impl true
  def handle_info({BlocWeb.BlockLive.FormComponent, {:saved, block}}, socket) do
    {:noreply, socket |> stream_insert(:blocks, block) |> apply_action(:index, %{})}
  end

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
    start_time = window_to_date_time(socket.assigns.scope, window)

    task = Tasks.get_task!(task_id)
    end_time = start_time |> DateTime.add(task.estimated_minutes || 30, :minute)

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
        {:noreply, socket |> put_flash(:error, "Failed to create block")}
    end
  end

  def handle_event("move_block", %{"id" => block_id, "window" => window}, socket) do
    start_time = window_to_date_time(socket.assigns.scope, window)

    block = Blocks.get_block!(block_id)
    diff = DateTime.diff(block.end_time, block.start_time, :minute)
    end_time = DateTime.add(start_time, diff, :minute)

    update_block(socket, block_id, %{start_time: start_time, end_time: end_time})
  end

  def handle_event("resize_up", %{"id" => block_id, "window" => window}, socket) do
    update_block(socket, block_id, %{
      start_time: window_to_date_time(socket.assigns.scope, window)
    })
  end

  def handle_event("resize_down", %{"id" => block_id, "window" => window}, socket) do
    update_block(socket, block_id, %{
      end_time: window_to_date_time(socket.assigns.scope, window + 1)
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

        {:noreply, socket |> put_flash(:error, "Failed to update block")}
    end
  end

  defp window_to_date_time(%Scope{timezone: timezone}, window) do
    window = window - 1
    time_from_minutes = Time.from_seconds_after_midnight(window * 15 * 60)

    timezone
    |> Timex.today()
    |> DateTime.new!(time_from_minutes, timezone)
    |> Timex.Timezone.convert("UTC")
  end
end
