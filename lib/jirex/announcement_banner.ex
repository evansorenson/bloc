defmodule Jirex.AnnouncementBanner do
  @moduledoc """
  Provides API endpoints related to announcement banner
  """

  @default_client Jirex.Client

  @doc """
  Get announcement banner configuration

  Returns the current announcement banner configuration.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_banner(keyword) ::
          {:ok, Jirex.AnnouncementBannerConfiguration.t()} | {:error, Jirex.ErrorCollection.t()}
  def get_banner(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.AnnouncementBanner, :get_banner},
      url: "/rest/api/2/announcementBanner",
      method: :get,
      response: [
        {200, {Jirex.AnnouncementBannerConfiguration, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update announcement banner configuration

  Updates the announcement banner configuration.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_banner(Jirex.AnnouncementBannerConfigurationUpdate.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def set_banner(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.AnnouncementBanner, :set_banner},
      url: "/rest/api/2/announcementBanner",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.AnnouncementBannerConfigurationUpdate, :t}}],
      response: [
        {204, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
