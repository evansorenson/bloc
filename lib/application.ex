defmodule Bloc.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Bloc.Repo,
      {DNSCluster, query: Application.get_env(:bloc, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Bloc.PubSub},
      {Finch, name: Bloc.Finch},
      BlocWeb.Telemetry,
      BlocWeb.Endpoint,
      {Finch, name: Jirex.Adapter.Finch}
    ]

    opts = [strategy: :one_for_one, name: Bloc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    BlocWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
