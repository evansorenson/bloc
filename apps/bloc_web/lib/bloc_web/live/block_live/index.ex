defmodule BlocWeb.BlockLive.Index do
  use BlocWeb, :live_view

  alias Bloc.Blocks
  alias Bloc.Blocks.Block

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :blocks, Blocks.list_blocks(socket.assigns.current_user))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Block")
    |> assign(:block, Blocks.get_block!(id))
  end

  defp apply_action(socket, :new, _params) do
    first_available_time =
      socket.assigns.current_user |> Blocks.list_blocks() |> Blocks.first_available_time()

    socket
    |> assign(:page_title, "New Block")
    |> assign(:block, %Block{
      start_time: first_available_time,
      end_time: first_available_time |> DateTime.add(1, :hour)
    })
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Blocks")
    |> assign(:block, nil)
  end

  @impl true
  def handle_info({BlocWeb.BlockLive.FormComponent, {:saved, block}}, socket) do
    {:noreply, stream_insert(socket, :blocks, block)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    block = Blocks.get_block!(id)
    {:ok, _} = Blocks.delete_block(block)

    {:noreply, stream_delete(socket, :blocks, block)}
  end
end
