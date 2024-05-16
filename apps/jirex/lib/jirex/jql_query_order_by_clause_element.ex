defmodule Jirex.JqlQueryOrderByClauseElement do
  @moduledoc """
  Provides struct and type for a JqlQueryOrderByClauseElement
  """

  @type t :: %__MODULE__{direction: String.t() | nil, field: Jirex.JqlQueryField.t()}

  defstruct [:direction, :field]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [direction: {:enum, ["asc", "desc"]}, field: {Jirex.JqlQueryField, :t}]
  end
end
