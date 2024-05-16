defmodule Jirex.Configuration do
  @moduledoc """
  Provides struct and type for a Configuration
  """

  @type t :: %__MODULE__{
          attachmentsEnabled: boolean | nil,
          issueLinkingEnabled: boolean | nil,
          subTasksEnabled: boolean | nil,
          timeTrackingConfiguration: Jirex.ConfigurationTimeTrackingConfiguration.t() | nil,
          timeTrackingEnabled: boolean | nil,
          unassignedIssuesAllowed: boolean | nil,
          votingEnabled: boolean | nil,
          watchingEnabled: boolean | nil
        }

  defstruct [
    :attachmentsEnabled,
    :issueLinkingEnabled,
    :subTasksEnabled,
    :timeTrackingConfiguration,
    :timeTrackingEnabled,
    :unassignedIssuesAllowed,
    :votingEnabled,
    :watchingEnabled
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      attachmentsEnabled: :boolean,
      issueLinkingEnabled: :boolean,
      subTasksEnabled: :boolean,
      timeTrackingConfiguration: {Jirex.ConfigurationTimeTrackingConfiguration, :t},
      timeTrackingEnabled: :boolean,
      unassignedIssuesAllowed: :boolean,
      votingEnabled: :boolean,
      watchingEnabled: :boolean
    ]
  end
end
