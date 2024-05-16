defmodule Jirex.LicenseMetrics do
  @moduledoc """
  Provides API endpoints related to license metrics
  """

  @default_client Jirex.Client

  @doc """
  Get approximate application license count

  Returns the total approximate number of user accounts for a single Jira license. Note that this information is cached with a 7-day lifecycle and could be stale at the time of call.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_approximate_application_license_count(String.t(), keyword) ::
          {:ok, Jirex.LicenseMetric.t()} | {:error, Jirex.ErrorCollection.t()}
  def get_approximate_application_license_count(applicationKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [applicationKey: applicationKey],
      call: {Jirex.LicenseMetrics, :get_approximate_application_license_count},
      url: "/rest/api/2/license/approximateLicenseCount/product/#{applicationKey}",
      method: :get,
      response: [
        {200, {Jirex.LicenseMetric, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
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
          {:ok, Jirex.LicenseMetric.t()} | {:error, Jirex.ErrorCollections.t()}
  def get_approximate_license_count(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.LicenseMetrics, :get_approximate_license_count},
      url: "/rest/api/2/license/approximateLicenseCount",
      method: :get,
      response: [
        {200, {Jirex.LicenseMetric, :t}},
        {401, {Jirex.ErrorCollections, :t}},
        {403, {Jirex.ErrorCollections, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get license

  Returns licensing information about the Jira instance.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_license(keyword) :: {:ok, Jirex.License.t()} | :error
  def get_license(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.LicenseMetrics, :get_license},
      url: "/rest/api/2/instance/license",
      method: :get,
      response: [{200, {Jirex.License, :t}}, {401, :null}],
      opts: opts
    })
  end
end
