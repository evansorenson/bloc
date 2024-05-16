defmodule BlocWeb.BlockLive.FormComponent do
  @moduledoc false
  use BlocWeb, :live_component

  alias Bloc.Blocks

  attr(:scope, Bloc.Scope, required: true)
  attr(:disabled, :boolean, default: false)

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage block records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="block-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:start_time]} type="datetime-local" label="Start time" />
        <.input field={@form[:end_time]} type="datetime-local" label="End time" />
        <:actions>
          <.button disabled={@disabled}>
            Save Block
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{block: block} = assigns, socket) do
    changeset = Blocks.change_block(block)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"block" => block_params}, socket) do
    changeset =
      socket.assigns.block
      |> Map.put("user_id", socket.assigns.scope.current_user.id)
      |> Blocks.change_block(block_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"block" => block_params}, socket) do
    save_block(socket, socket.assigns.action, block_params)
  end

  defp save_block(socket, :edit, block_params) do
    case Blocks.update_block(socket.assigns.block, block_params) do
      {:ok, block} ->
        notify_parent({:saved, block})

        {:noreply, put_flash!(socket, :info, "Block updated successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_block(socket, :new, block_params) do
    block_params
    |> Map.put("user_id", socket.assigns.scope.current_user.id)
    |> Blocks.create_block()
    |> case do
      {:ok, block} ->
        notify_parent({:saved, block})

        {:noreply,
         socket
         |> assign(:disabled, true)
         |> put_flash!(:info, "Block created successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
