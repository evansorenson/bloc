defmodule Jira.SearchResults do
  @moduledoc """
  Provides struct and type for a SearchResults
  """

  @type t :: %__MODULE__{
          expand: String.t() | nil,
          issues: [Jira.IssueBean.t()] | nil,
          maxResults: integer | nil,
          names: Jira.SearchResultsNames.t() | nil,
          schema: Jira.SearchResultsSchema.t() | nil,
          startAt: integer | nil,
          total: integer | nil,
          warningMessages: [String.t()] | nil
        }

  defstruct [:expand, :issues, :maxResults, :names, :schema, :startAt, :total, :warningMessages]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      expand: {:string, :generic},
      issues: [{Jira.IssueBean, :t}],
      maxResults: :integer,
      names: {Jira.SearchResultsNames, :t},
      schema: {Jira.SearchResultsSchema, :t},
      startAt: :integer,
      total: :integer,
      warningMessages: [string: :generic]
    ]
  end
end
