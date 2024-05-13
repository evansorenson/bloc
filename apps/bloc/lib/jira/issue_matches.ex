defmodule Jira.IssueMatches do
  @moduledoc """
  Provides struct and type for a IssueMatches
  """

  @type t :: %__MODULE__{matches: [Jira.IssueMatchesForJQL.t()]}

  defstruct [:matches]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [matches: [{Jira.IssueMatchesForJQL, :t}]]
  end
end
