defmodule Jirex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: Jirex.Adapter.Finch}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Jirex.Supervisor)
  end
end
