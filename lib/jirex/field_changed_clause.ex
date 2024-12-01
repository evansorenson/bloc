defmodule Jirex.FieldChangedClause do
  @moduledoc """
  Provides struct and type for a FieldChangedClause
  """

  @type t :: %__MODULE__{
          field: Jirex.JqlQueryField.t(),
          operator: String.t(),
          predicates: [Jirex.JqlQueryClauseTimePredicate.t()]
        }

  defstruct [:field, :operator, :predicates]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      field: {Jirex.JqlQueryField, :t},
      operator: {:const, "changed"},
      predicates: [{Jirex.JqlQueryClauseTimePredicate, :t}]
    ]
  end
end
