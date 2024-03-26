defmodule Bloc.Repo do
  use Ecto.Repo,
    otp_app: :bloc,
    adapter: Ecto.Adapters.Postgres
end
