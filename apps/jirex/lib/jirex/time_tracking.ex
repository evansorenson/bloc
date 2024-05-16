defmodule Jirex.TimeTracking do
  @moduledoc """
  Provides API endpoints related to time tracking
  """

  @default_client Jirex.Client

  @doc """
  Get all time tracking providers

  Returns all time tracking providers. By default, Jira only has one time tracking provider: *JIRA provided time tracking*. However, you can install other time tracking providers via apps from the Atlassian Marketplace. For more information on time tracking providers, see the documentation for the [ Time Tracking Provider](https://developer.atlassian.com/cloud/jira/platform/modules/time-tracking-provider/) module.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_available_time_tracking_implementations(keyword) ::
          {:ok, [Jirex.TimeTrackingProvider.t()]} | :error
  def get_available_time_tracking_implementations(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.TimeTracking, :get_available_time_tracking_implementations},
      url: "/rest/api/2/configuration/timetracking/list",
      method: :get,
      response: [{200, [{Jirex.TimeTrackingProvider, :t}]}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get selected time tracking provider

  Returns the time tracking provider that is currently selected. Note that if time tracking is disabled, then a successful but empty response is returned.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_selected_time_tracking_implementation(keyword) ::
          {:ok, map | Jirex.TimeTrackingProvider.t()} | :error
  def get_selected_time_tracking_implementation(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.TimeTracking, :get_selected_time_tracking_implementation},
      url: "/rest/api/2/configuration/timetracking",
      method: :get,
      response: [{200, {Jirex.TimeTrackingProvider, :t}}, {204, :map}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get time tracking settings

  Returns the time tracking settings. This includes settings such as the time format, default time unit, and others. For more information, see [Configuring time tracking](https://confluence.atlassian.com/x/qoXKM).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_shared_time_tracking_configuration(keyword) ::
          {:ok, Jirex.TimeTrackingConfiguration.t()} | :error
  def get_shared_time_tracking_configuration(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.TimeTracking, :get_shared_time_tracking_configuration},
      url: "/rest/api/2/configuration/timetracking/options",
      method: :get,
      response: [{200, {Jirex.TimeTrackingConfiguration, :t}}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Select time tracking provider

  Selects a time tracking provider.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec select_time_tracking_implementation(Jirex.TimeTrackingProvider.t(), keyword) ::
          {:ok, map} | :error
  def select_time_tracking_implementation(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.TimeTracking, :select_time_tracking_implementation},
      url: "/rest/api/2/configuration/timetracking",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.TimeTrackingProvider, :t}}],
      response: [{204, :map}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Set time tracking settings

  Sets the time tracking settings.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_shared_time_tracking_configuration(Jirex.TimeTrackingConfiguration.t(), keyword) ::
          {:ok, Jirex.TimeTrackingConfiguration.t()} | :error
  def set_shared_time_tracking_configuration(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.TimeTracking, :set_shared_time_tracking_configuration},
      url: "/rest/api/2/configuration/timetracking/options",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.TimeTrackingConfiguration, :t}}],
      response: [
        {200, {Jirex.TimeTrackingConfiguration, :t}},
        {400, :null},
        {401, :null},
        {403, :null}
      ],
      opts: opts
    })
  end
end
