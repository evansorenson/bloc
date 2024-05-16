defmodule Jirex.CompoundClause do
  @moduledoc """
  Provides struct and type for a CompoundClause
  """

  @type t :: %__MODULE__{
          clauses: [
            Jirex.CompoundClause.t()
            | Jirex.FieldChangedClause.t()
            | Jirex.FieldValueClause.t()
            | Jirex.FieldWasClause.t()
          ],
          operator: String.t()
        }

  defstruct [:clauses, :operator]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      clauses: [
        union: [
          {Jirex.CompoundClause, :t},
          {Jirex.FieldChangedClause, :t},
          {Jirex.FieldValueClause, :t},
          {Jirex.FieldWasClause, :t}
        ]
      ],
      operator: {:enum, ["and", "or", "not"]}
    ]
  end
end
