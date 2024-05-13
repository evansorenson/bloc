defmodule Jira.ParsedJqlQuery do
  @moduledoc """
  Provides struct and type for a ParsedJqlQuery
  """

  @type t :: %__MODULE__{
          errors: [String.t()] | nil,
          query: String.t(),
          structure: Jira.ParsedJqlQueryStructure.t() | nil
        }

  defstruct [:errors, :query, :structure]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      errors: [string: :generic],
      query: {:string, :generic},
      structure: {Jira.ParsedJqlQueryStructure, :t}
    ]
  end
end
