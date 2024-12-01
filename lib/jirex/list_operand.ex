defmodule Jirex.ListOperand do
  @moduledoc """
  Provides struct and type for a ListOperand
  """

  @type t :: %__MODULE__{
          encodedOperand: String.t() | nil,
          values: [Jirex.FunctionOperand.t() | Jirex.KeywordOperand.t() | Jirex.ValueOperand.t()]
        }

  defstruct [:encodedOperand, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      encodedOperand: {:string, :generic},
      values: [
        union: [{Jirex.FunctionOperand, :t}, {Jirex.KeywordOperand, :t}, {Jirex.ValueOperand, :t}]
      ]
    ]
  end
end
