defmodule Jira.VersionIssueCounts do
  @moduledoc """
  Provides struct and type for a VersionIssueCounts
  """

  @type t :: %__MODULE__{
          customFieldUsage: [Jira.VersionUsageInCustomField.t()] | nil,
          issueCountWithCustomFieldsShowingVersion: integer | nil,
          issuesAffectedCount: integer | nil,
          issuesFixedCount: integer | nil,
          self: String.t() | nil
        }

  defstruct [
    :customFieldUsage,
    :issueCountWithCustomFieldsShowingVersion,
    :issuesAffectedCount,
    :issuesFixedCount,
    :self
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      customFieldUsage: [{Jira.VersionUsageInCustomField, :t}],
      issueCountWithCustomFieldsShowingVersion: :integer,
      issuesAffectedCount: :integer,
      issuesFixedCount: :integer,
      self: {:string, :uri}
    ]
  end
end
