defmodule Jirex.JiraExpressionAnalysis do
  @moduledoc """
  Provides struct and type for a JiraExpressionAnalysis
  """

  @type t :: %__MODULE__{
          complexity: Jirex.JiraExpressionComplexity.t() | nil,
          errors: [Jirex.JiraExpressionValidationError.t()] | nil,
          expression: String.t(),
          type: String.t() | nil,
          valid: boolean
        }

  defstruct [:complexity, :errors, :expression, :type, :valid]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      complexity: {Jirex.JiraExpressionComplexity, :t},
      errors: [{Jirex.JiraExpressionValidationError, :t}],
      expression: {:string, :generic},
      type: {:string, :generic},
      valid: :boolean
    ]
  end
end
