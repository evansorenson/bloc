defmodule Bloc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Bloc.Repo,
      {DNSCluster, query: Application.get_env(:bloc, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Bloc.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Bloc.Finch}
      # Start a worker by calling: Bloc.Worker.start_link(arg)
      # {Bloc.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Bloc.Supervisor)
  end
end
