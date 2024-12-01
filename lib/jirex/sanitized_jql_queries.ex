defmodule Jirex.SanitizedJqlQueries do
  @moduledoc """
  Provides struct and type for a SanitizedJqlQueries
  """

  @type t :: %__MODULE__{queries: [Jirex.SanitizedJqlQuery.t()] | nil}

  defstruct [:queries]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [queries: [{Jirex.SanitizedJqlQuery, :t}]]
  end
end
