defmodule Jira.FieldChangedClause do
  @moduledoc """
  Provides struct and type for a FieldChangedClause
  """

  @type t :: %__MODULE__{
          field: Jira.JqlQueryField.t(),
          operator: String.t(),
          predicates: [Jira.JqlQueryClauseTimePredicate.t()]
        }

  defstruct [:field, :operator, :predicates]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      field: {Jira.JqlQueryField, :t},
      operator: {:const, "changed"},
      predicates: [{Jira.JqlQueryClauseTimePredicate, :t}]
    ]
  end
end
