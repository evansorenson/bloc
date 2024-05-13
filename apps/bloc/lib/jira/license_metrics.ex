defmodule Jira.LicenseMetrics do
  @moduledoc """
  Provides API endpoints related to license metrics
  """

  @default_client Jira.Client

  @doc """
  Get approximate application license count

  Returns the total approximate number of user accounts for a single Jira license. Note that this information is cached with a 7-day lifecycle and could be stale at the time of call.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_approximate_application_license_count(String.t(), keyword) ::
          {:ok, Jira.LicenseMetric.t()} | {:error, Jira.ErrorCollection.t()}
  def get_approximate_application_license_count(applicationKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [applicationKey: applicationKey],
      call: {Jira.LicenseMetrics, :get_approximate_application_license_count},
      url: "/rest/api/2/license/approximateLicenseCount/product/#{applicationKey}",
      method: :get,
      response: [
        {200, {Jira.LicenseMetric, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get approximate license count

  Returns the approximate number of user accounts across all Jira licenses. Note that this information is cached with a 7-day lifecycle and could be stale at the time of call.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_approximate_license_count(keyword) ::
          {:ok, Jira.LicenseMetric.t()} | {:error, Jira.ErrorCollections.t()}
  def get_approximate_license_count(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.LicenseMetrics, :get_approximate_license_count},
      url: "/rest/api/2/license/approximateLicenseCount",
      method: :get,
      response: [
        {200, {Jira.LicenseMetric, :t}},
        {401, {Jira.ErrorCollections, :t}},
        {403, {Jira.ErrorCollections, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get license

  Returns licensing information about the Jira instance.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_license(keyword) :: {:ok, Jira.License.t()} | :error
  def get_license(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.LicenseMetrics, :get_license},
      url: "/rest/api/2/instance/license",
      method: :get,
      response: [{200, {Jira.License, :t}}, {401, :null}],
      opts: opts
    })
  end
end
