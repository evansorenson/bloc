defmodule Vida.Repo do
  use Ecto.Repo,
    otp_app: :vida,
    adapter: Ecto.Adapters.Postgres
end
