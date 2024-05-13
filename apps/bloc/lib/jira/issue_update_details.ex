defmodule Jira.IssueUpdateDetails do
  @moduledoc """
  Provides struct and type for a IssueUpdateDetails
  """

  @type t :: %__MODULE__{
          fields: Jira.IssueUpdateDetailsFields.t() | nil,
          historyMetadata: Jira.IssueUpdateDetailsHistoryMetadata.t() | nil,
          properties: [Jira.EntityProperty.t()] | nil,
          transition: Jira.IssueUpdateDetailsTransition.t() | nil,
          update: Jira.IssueUpdateDetailsUpdate.t() | nil
        }

  defstruct [:fields, :historyMetadata, :properties, :transition, :update]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      fields: {Jira.IssueUpdateDetailsFields, :t},
      historyMetadata: {Jira.IssueUpdateDetailsHistoryMetadata, :t},
      properties: [{Jira.EntityProperty, :t}],
      transition: {Jira.IssueUpdateDetailsTransition, :t},
      update: {Jira.IssueUpdateDetailsUpdate, :t}
    ]
  end
end
