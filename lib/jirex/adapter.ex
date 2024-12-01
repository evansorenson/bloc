defmodule Jirex.Adapter do
  @moduledoc """
  Custom Tesla adapter using Finch.
  """

  alias Tesla.Adapter
  alias Tesla.Adapter.Finch

  @behaviour Tesla.Adapter

  # Refers to connection pool started in application.ex
  @default_opts [
    name: Jirex.Adapter.Finch,
    # Timeout to get a connection from the pool
    pool_timeout: 5000
  ]

  @impl true
  def call(env, attrs) do
    opts = Adapter.opts(@default_opts, env, Map.to_list(attrs))
    Finch.call(env, opts)
  end
end
