defmodule Jira.AnnouncementBanner do
  @moduledoc """
  Provides API endpoints related to announcement banner
  """

  @default_client Jira.Client

  @doc """
  Get announcement banner configuration

  Returns the current announcement banner configuration.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_banner(keyword) ::
          {:ok, Jira.AnnouncementBannerConfiguration.t()} | {:error, Jira.ErrorCollection.t()}
  def get_banner(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.AnnouncementBanner, :get_banner},
      url: "/rest/api/2/announcementBanner",
      method: :get,
      response: [
        {200, {Jira.AnnouncementBannerConfiguration, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update announcement banner configuration

  Updates the announcement banner configuration.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_banner(Jira.AnnouncementBannerConfigurationUpdate.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def set_banner(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.AnnouncementBanner, :set_banner},
      url: "/rest/api/2/announcementBanner",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.AnnouncementBannerConfigurationUpdate, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
