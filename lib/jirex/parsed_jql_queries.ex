defmodule Jirex.ParsedJqlQueries do
  @moduledoc """
  Provides struct and type for a ParsedJqlQueries
  """

  @type t :: %__MODULE__{queries: [Jirex.ParsedJqlQuery.t()]}

  defstruct [:queries]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [queries: [{Jirex.ParsedJqlQuery, :t}]]
  end
end
