defmodule Jira.JiraExpressionResultMetaComplexityPrimitiveValues do
  @moduledoc """
  Provides struct and type for a JiraExpressionResultMetaComplexityPrimitiveValues
  """

  @type t :: %__MODULE__{limit: integer | nil, value: integer | nil}

  defstruct [:limit, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [limit: :integer, value: :integer]
  end
end
