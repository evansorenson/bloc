defmodule Jirex.JqlQueryClauseTimePredicate do
  @moduledoc """
  Provides struct and type for a JqlQueryClauseTimePredicate
  """

  @type t :: %__MODULE__{
          operand:
            Jirex.FunctionOperand.t()
            | Jirex.KeywordOperand.t()
            | Jirex.ListOperand.t()
            | Jirex.ValueOperand.t(),
          operator: String.t()
        }

  defstruct [:operand, :operator]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      operand:
        {:union,
         [
           {Jirex.FunctionOperand, :t},
           {Jirex.KeywordOperand, :t},
           {Jirex.ListOperand, :t},
           {Jirex.ValueOperand, :t}
         ]},
      operator: {:enum, ["before", "after", "from", "to", "on", "during", "by"]}
    ]
  end
end
