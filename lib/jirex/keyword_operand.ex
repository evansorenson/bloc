defmodule Jirex.KeywordOperand do
  @moduledoc """
  Provides struct and type for a KeywordOperand
  """

  @type t :: %__MODULE__{keyword: String.t()}

  defstruct [:keyword]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [keyword: {:const, "empty"}]
  end
end
