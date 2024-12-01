defmodule Jirex.ParsedJqlQuery do
  @moduledoc """
  Provides struct and type for a ParsedJqlQuery
  """

  @type t :: %__MODULE__{
          errors: [String.t()] | nil,
          query: String.t(),
          structure: Jirex.ParsedJqlQueryStructure.t() | nil
        }

  defstruct [:errors, :query, :structure]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      errors: [string: :generic],
      query: {:string, :generic},
      structure: {Jirex.ParsedJqlQueryStructure, :t}
    ]
  end
end
