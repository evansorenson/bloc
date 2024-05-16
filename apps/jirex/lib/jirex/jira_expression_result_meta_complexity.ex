defmodule Jirex.JiraExpressionResultMetaComplexity do
  @moduledoc """
  Provides struct and type for a JiraExpressionResultMetaComplexity
  """

  @type t :: %__MODULE__{
          beans: Jirex.JiraExpressionResultMetaComplexityBeans.t() | nil,
          expensiveOperations:
            Jirex.JiraExpressionResultMetaComplexityExpensiveOperations.t() | nil,
          primitiveValues: Jirex.JiraExpressionResultMetaComplexityPrimitiveValues.t() | nil,
          steps: Jirex.JiraExpressionResultMetaComplexitySteps.t() | nil
        }

  defstruct [:beans, :expensiveOperations, :primitiveValues, :steps]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      beans: {Jirex.JiraExpressionResultMetaComplexityBeans, :t},
      expensiveOperations: {Jirex.JiraExpressionResultMetaComplexityExpensiveOperations, :t},
      primitiveValues: {Jirex.JiraExpressionResultMetaComplexityPrimitiveValues, :t},
      steps: {Jirex.JiraExpressionResultMetaComplexitySteps, :t}
    ]
  end
end
