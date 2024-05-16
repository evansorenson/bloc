defmodule Jirex.FieldValueClause do
  @moduledoc """
  Provides struct and type for a FieldValueClause
  """

  @type t :: %__MODULE__{
          field: Jirex.JqlQueryField.t(),
          operand:
            Jirex.FunctionOperand.t()
            | Jirex.KeywordOperand.t()
            | Jirex.ListOperand.t()
            | Jirex.ValueOperand.t(),
          operator: String.t()
        }

  defstruct [:field, :operand, :operator]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      field: {Jirex.JqlQueryField, :t},
      operand:
        {:union,
         [
           {Jirex.FunctionOperand, :t},
           {Jirex.KeywordOperand, :t},
           {Jirex.ListOperand, :t},
           {Jirex.ValueOperand, :t}
         ]},
      operator:
        {:enum, ["=", "!=", ">", "<", ">=", "<=", "in", "not in", "~", "~=", "is", "is not"]}
    ]
  end
end
