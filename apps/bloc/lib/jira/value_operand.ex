defmodule Jira.ValueOperand do
  @moduledoc """
  Provides struct and type for a ValueOperand
  """

  @type t :: %__MODULE__{encodedValue: String.t() | nil, value: String.t()}

  defstruct [:encodedValue, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [encodedValue: {:string, :generic}, value: {:string, :generic}]
  end
end
