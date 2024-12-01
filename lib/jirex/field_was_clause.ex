defmodule Jirex.FieldWasClause do
  @moduledoc """
  Provides struct and type for a FieldWasClause
  """

  @type t :: %__MODULE__{
          field: Jirex.JqlQueryField.t(),
          operand:
            Jirex.FunctionOperand.t()
            | Jirex.KeywordOperand.t()
            | Jirex.ListOperand.t()
            | Jirex.ValueOperand.t(),
          operator: String.t(),
          predicates: [Jirex.JqlQueryClauseTimePredicate.t()]
        }

  defstruct [:field, :operand, :operator, :predicates]

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
      operator: {:enum, ["was", "was in", "was not in", "was not"]},
      predicates: [{Jirex.JqlQueryClauseTimePredicate, :t}]
    ]
  end
end
