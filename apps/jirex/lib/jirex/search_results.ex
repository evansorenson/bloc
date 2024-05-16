defmodule Jirex.SearchResults do
  @moduledoc """
  Provides struct and type for a SearchResults
  """

  @type t :: %__MODULE__{
          expand: String.t() | nil,
          issues: [Jirex.IssueBean.t()] | nil,
          maxResults: integer | nil,
          names: Jirex.SearchResultsNames.t() | nil,
          schema: Jirex.SearchResultsSchema.t() | nil,
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
      issues: [{Jirex.IssueBean, :t}],
      maxResults: :integer,
      names: {Jirex.SearchResultsNames, :t},
      schema: {Jirex.SearchResultsSchema, :t},
      startAt: :integer,
      total: :integer,
      warningMessages: [string: :generic]
    ]
  end
end
