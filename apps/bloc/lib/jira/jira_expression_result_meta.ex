defmodule Jira.JiraExpressionResultMeta do
  @moduledoc """
  Provides struct and type for a JiraExpressionResultMeta
  """

  @type t :: %__MODULE__{
          complexity: Jira.JiraExpressionResultMetaComplexity.t() | nil,
          issues: Jira.JiraExpressionResultMetaIssues.t() | nil
        }

  defstruct [:complexity, :issues]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      complexity: {Jira.JiraExpressionResultMetaComplexity, :t},
      issues: {Jira.JiraExpressionResultMetaIssues, :t}
    ]
  end
end
