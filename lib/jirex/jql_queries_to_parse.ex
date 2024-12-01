defmodule Jirex.JqlQueriesToParse do
  @moduledoc """
  Provides struct and type for a JqlQueriesToParse
  """

  @type t :: %__MODULE__{queries: [String.t()]}

  defstruct [:queries]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [queries: [string: :generic]]
  end
end
