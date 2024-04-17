# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :bloc,
  ecto_repos: [Bloc.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :bloc, Bloc.Mailer, adapter: Swoosh.Adapters.Local

config :bloc_web,
  ecto_repos: [Bloc.Repo],
  generators: [
    context_app: :bloc,
    migration: true,
    binary_id: true,
    timestamp_type: :utc_datetime,
    sample_binary_id: "11111111-1111-1111-1111-111111111111"
  ]

# Configures the endpoint
config :bloc_web, BlocWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: BlocWeb.ErrorHTML, json: BlocWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Bloc.PubSub,
  live_view: [signing_salt: "Po8vqhkA"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  bloc_web: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/bloc_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.0",
  bloc_web: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/bloc_web/assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

config :query_builder, :default_page_size, 100

config :bloc, Oban,
  engine: Oban.Engines.Basic,
  queues: [default: 10],
  repo: Bloc.Repo,
  plugins: [
    {Oban.Plugins.Cron,
     crontab: [
       {"@midnight", Bloc.Workers.HabitTask}
     ],
     timezone: "America/Chicago"},
    {Oban.Plugins.Pruner, max_age: 60 * 60 * 24 * 7},
    {Oban.Plugins.Lifeline, rescue_after: :timer.minutes(30)}
  ]
