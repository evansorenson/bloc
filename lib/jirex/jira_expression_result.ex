defmodule Jirex.JiraExpressionResult do
  @moduledoc """
  Provides struct and type for a JiraExpressionResult
  """

  @type t :: %__MODULE__{meta: Jirex.JiraExpressionResultMeta.t() | nil, value: map}

  defstruct [:meta, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [meta: {Jirex.JiraExpressionResultMeta, :t}, value: :map]
  end
end
