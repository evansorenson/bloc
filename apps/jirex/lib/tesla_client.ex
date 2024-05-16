defmodule Jirex.TeslaClient do
  use Tesla

  # plug(
  #   Tesla.Middleware.BasicAuth,
  #   %{
  #     username: Application.get_env(:jirex, :username),
  #     password: Application.get_env(:jirex, :password)
  #   }
  # )

  # plug(Tesla.Middleware.BaseUrl, base_url: Application.get_env(:jirex, :base_url))
  # adapter(Jirex.Adapter)

  def new(opts \\ %{}) do
    base_url = Application.fetch_env!(:jirex, :base_url)

    basic_auth = %{
      password: Application.fetch_env!(:jirex, :password),
      username: Application.fetch_env!(:jirex, :username)
    }

    Tesla.client(
      [
        {Tesla.Middleware.BaseUrl, base_url},
        {Tesla.Middleware.BasicAuth, basic_auth}
      ],
      {Jirex.Adapter, opts}
    )
  end
end
