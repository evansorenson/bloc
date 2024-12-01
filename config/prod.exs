import Config

config :bloc, BlocWeb.Endpoint,
  url: [host: "bloc.fly.dev", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :swoosh, :api_client, Bloc.Finch

config :swoosh, local: false

config :logger, level: :info
