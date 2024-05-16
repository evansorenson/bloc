defmodule Jirex.JqlQueriesToSanitize do
  @moduledoc """
  Provides struct and type for a JqlQueriesToSanitize
  """

  @type t :: %__MODULE__{queries: [Jirex.JqlQueryToSanitize.t()]}

  defstruct [:queries]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [queries: [{Jirex.JqlQueryToSanitize, :t}]]
  end
end
