defmodule BlocWeb.BlockLive.Index do
  use BlocWeb, :live_view

  alias Bloc.Blocks
  alias Bloc.Blocks.Block

  on_mount({BlocWeb.UserAuth, :ensure_authenticated})
  on_mount(BlocWeb.Scope)

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :blocks, Blocks.list_blocks(socket.assigns.current_user))}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Block")
    |> assign(:live_action, :edit)
    |> assign(:block, Blocks.get_block!(id))
  end

  defp apply_action(socket, :new, _params) do
    first_available_time =
      socket.assigns.current_user |> Blocks.list_blocks() |> Blocks.first_available_time()

    IO.inspect("new block")

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
end
