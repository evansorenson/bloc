defmodule Jira.JiraExpressionResultMetaComplexity do
  @moduledoc """
  Provides struct and type for a JiraExpressionResultMetaComplexity
  """

  @type t :: %__MODULE__{
          beans: Jira.JiraExpressionResultMetaComplexityBeans.t() | nil,
          expensiveOperations:
            Jira.JiraExpressionResultMetaComplexityExpensiveOperations.t() | nil,
          primitiveValues: Jira.JiraExpressionResultMetaComplexityPrimitiveValues.t() | nil,
          steps: Jira.JiraExpressionResultMetaComplexitySteps.t() | nil
        }

  defstruct [:beans, :expensiveOperations, :primitiveValues, :steps]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      beans: {Jira.JiraExpressionResultMetaComplexityBeans, :t},
      expensiveOperations: {Jira.JiraExpressionResultMetaComplexityExpensiveOperations, :t},
      primitiveValues: {Jira.JiraExpressionResultMetaComplexityPrimitiveValues, :t},
      steps: {Jira.JiraExpressionResultMetaComplexitySteps, :t}
    ]
  end
end
