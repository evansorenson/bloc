defmodule Jirex.ServerInformation do
  @moduledoc """
  Provides struct and type for a ServerInformation
  """

  @type t :: %__MODULE__{
          baseUrl: String.t() | nil,
          buildDate: DateTime.t() | nil,
          buildNumber: integer | nil,
          deploymentType: String.t() | nil,
          displayUrl: String.t() | nil,
          displayUrlServicedeskHelpCenter: String.t() | nil,
          healthChecks: [Jirex.HealthCheckResult.t()] | nil,
          scmInfo: String.t() | nil,
          serverTime: DateTime.t() | nil,
          serverTimeZone: Jirex.ServerInformationServerTimeZone.t() | nil,
          serverTitle: String.t() | nil,
          version: String.t() | nil,
          versionNumbers: [integer] | nil
        }

  defstruct [
    :baseUrl,
    :buildDate,
    :buildNumber,
    :deploymentType,
    :displayUrl,
    :displayUrlServicedeskHelpCenter,
    :healthChecks,
    :scmInfo,
    :serverTime,
    :serverTimeZone,
    :serverTitle,
    :version,
    :versionNumbers
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      baseUrl: {:string, :generic},
      buildDate: {:string, :date_time},
      buildNumber: :integer,
      deploymentType: {:string, :generic},
      displayUrl: {:string, :generic},
      displayUrlServicedeskHelpCenter: {:string, :generic},
      healthChecks: [{Jirex.HealthCheckResult, :t}],
      scmInfo: {:string, :generic},
      serverTime: {:string, :date_time},
      serverTimeZone: {Jirex.ServerInformationServerTimeZone, :t},
      serverTitle: {:string, :generic},
      version: {:string, :generic},
      versionNumbers: [:integer]
    ]
  end
end
