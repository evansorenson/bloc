defmodule Jirex.PageOfCreateMetaIssueTypes do
  @moduledoc """
  Provides struct and type for a PageOfCreateMetaIssueTypes
  """

  @type t :: %__MODULE__{
          createMetaIssueType: [Jirex.IssueTypeIssueCreateMetadata.t()] | nil,
          issueTypes: [Jirex.IssueTypeIssueCreateMetadata.t()] | nil,
          maxResults: integer | nil,
          startAt: integer | nil,
          total: integer | nil
        }

  defstruct [:createMetaIssueType, :issueTypes, :maxResults, :startAt, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      createMetaIssueType: [{Jirex.IssueTypeIssueCreateMetadata, :t}],
      issueTypes: [{Jirex.IssueTypeIssueCreateMetadata, :t}],
      maxResults: :integer,
      startAt: :integer,
      total: :integer
    ]
  end
end
