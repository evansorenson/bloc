defmodule Jirex.JiraExpressionsAnalysis do
  @moduledoc """
  Provides struct and type for a JiraExpressionsAnalysis
  """

  @type t :: %__MODULE__{results: [Jirex.JiraExpressionAnalysis.t()]}

  defstruct [:results]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [results: [{Jirex.JiraExpressionAnalysis, :t}]]
  end
end
