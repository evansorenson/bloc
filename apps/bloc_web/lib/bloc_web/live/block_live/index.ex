defmodule BlocWeb.BlockLive.Index do
  use BlocWeb, :live_view

  alias Bloc.Blocks
  alias Bloc.Blocks.Block

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :blocks, Blocks.list_blocks())}
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
    socket
    |> assign(:page_title, "New Block")
    |> assign(:block, %Block{})
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
