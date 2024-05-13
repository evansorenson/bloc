defmodule Jira.BulkIssueIsWatching do
  @moduledoc """
  Provides struct and type for a BulkIssueIsWatching
  """

  @type t :: %__MODULE__{issuesIsWatching: Jira.BulkIssueIsWatchingIssuesIsWatching.t() | nil}

  defstruct [:issuesIsWatching]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issuesIsWatching: {Jira.BulkIssueIsWatchingIssuesIsWatching, :t}]
  end
end
