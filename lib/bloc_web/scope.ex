defmodule BlocWeb.Scope do
  @moduledoc false
  def on_mount(:default, _params, _session, socket) do
    current_user = socket.assigns[:current_user]
    {:cont, Phoenix.Component.assign(socket, :scope, Bloc.Scope.for_user(current_user))}
  end
end
