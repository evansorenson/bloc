defmodule Jira.ParsedJqlQueryStructure do
  @moduledoc """
  Provides struct and type for a ParsedJqlQueryStructure
  """

  @type t :: %__MODULE__{
          orderBy: Jira.JqlQueryOrderByClause.t() | nil,
          where:
            Jira.CompoundClause.t()
            | Jira.FieldChangedClause.t()
            | Jira.FieldValueClause.t()
            | Jira.FieldWasClause.t()
            | nil
        }

  defstruct [:orderBy, :where]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      orderBy: {Jira.JqlQueryOrderByClause, :t},
      where:
        {:union,
         [
           {Jira.CompoundClause, :t},
           {Jira.FieldChangedClause, :t},
           {Jira.FieldValueClause, :t},
           {Jira.FieldWasClause, :t}
         ]}
    ]
  end
end
