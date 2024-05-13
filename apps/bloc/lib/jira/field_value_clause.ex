defmodule Jira.FieldValueClause do
  @moduledoc """
  Provides struct and type for a FieldValueClause
  """

  @type t :: %__MODULE__{
          field: Jira.JqlQueryField.t(),
          operand:
            Jira.FunctionOperand.t()
            | Jira.KeywordOperand.t()
            | Jira.ListOperand.t()
            | Jira.ValueOperand.t(),
          operator: String.t()
        }

  defstruct [:field, :operand, :operator]

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
      operator:
        {:enum, ["=", "!=", ">", "<", ">=", "<=", "in", "not in", "~", "~=", "is", "is not"]}
    ]
  end
end
