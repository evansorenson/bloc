defmodule Jirex.ParsedJqlQueryStructure do
  @moduledoc """
  Provides struct and type for a ParsedJqlQueryStructure
  """

  @type t :: %__MODULE__{
          orderBy: Jirex.JqlQueryOrderByClause.t() | nil,
          where:
            Jirex.CompoundClause.t()
            | Jirex.FieldChangedClause.t()
            | Jirex.FieldValueClause.t()
            | Jirex.FieldWasClause.t()
            | nil
        }

  defstruct [:orderBy, :where]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      orderBy: {Jirex.JqlQueryOrderByClause, :t},
      where:
        {:union,
         [
           {Jirex.CompoundClause, :t},
           {Jirex.FieldChangedClause, :t},
           {Jirex.FieldValueClause, :t},
           {Jirex.FieldWasClause, :t}
         ]}
    ]
  end
end
