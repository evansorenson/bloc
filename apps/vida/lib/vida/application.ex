defmodule Vida.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Vida.Repo,
      {DNSCluster, query: Application.get_env(:vida, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Vida.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Vida.Finch}
      # Start a worker by calling: Vida.Worker.start_link(arg)
      # {Vida.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Vida.Supervisor)
  end
end
