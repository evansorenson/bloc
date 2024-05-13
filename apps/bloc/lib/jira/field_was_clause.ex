defmodule Jira.FieldWasClause do
  @moduledoc """
  Provides struct and type for a FieldWasClause
  """

  @type t :: %__MODULE__{
          field: Jira.JqlQueryField.t(),
          operand:
            Jira.FunctionOperand.t()
            | Jira.KeywordOperand.t()
            | Jira.ListOperand.t()
            | Jira.ValueOperand.t(),
          operator: String.t(),
          predicates: [Jira.JqlQueryClauseTimePredicate.t()]
        }

  defstruct [:field, :operand, :operator, :predicates]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      field: {Jira.JqlQueryField, :t},
      operand:
        {:union,
         [
           {Jira.FunctionOperand, :t},
           {Jira.KeywordOperand, :t},
           {Jira.ListOperand, :t},
           {Jira.ValueOperand, :t}
         ]},
      operator: {:enum, ["was", "was in", "was not in", "was not"]},
      predicates: [{Jira.JqlQueryClauseTimePredicate, :t}]
    ]
  end
end
