defmodule Jirex.JqlQueryOrderByClause do
  @moduledoc """
  Provides struct and type for a JqlQueryOrderByClause
  """

  @type t :: %__MODULE__{fields: [Jirex.JqlQueryOrderByClauseElement.t()]}

  defstruct [:fields]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fields: [{Jirex.JqlQueryOrderByClauseElement, :t}]]
  end
end
