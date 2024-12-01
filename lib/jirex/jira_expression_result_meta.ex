defmodule Jirex.JiraExpressionResultMeta do
  @moduledoc """
  Provides struct and type for a JiraExpressionResultMeta
  """

  @type t :: %__MODULE__{
          complexity: Jirex.JiraExpressionResultMetaComplexity.t() | nil,
          issues: Jirex.JiraExpressionResultMetaIssues.t() | nil
        }

  defstruct [:complexity, :issues]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      complexity: {Jirex.JiraExpressionResultMetaComplexity, :t},
      issues: {Jirex.JiraExpressionResultMetaIssues, :t}
    ]
  end
end
