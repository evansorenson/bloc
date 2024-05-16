defmodule Jirex.FunctionOperand do
  @moduledoc """
  Provides struct and type for a FunctionOperand
  """

  @type t :: %__MODULE__{
          arguments: [String.t()],
          encodedOperand: String.t() | nil,
          function: String.t()
        }

  defstruct [:arguments, :encodedOperand, :function]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      arguments: [string: :generic],
      encodedOperand: {:string, :generic},
      function: {:string, :generic}
    ]
  end
end
