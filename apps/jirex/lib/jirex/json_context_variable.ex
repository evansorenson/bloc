defmodule Jirex.JsonContextVariable do
  @moduledoc """
  Provides struct and type for a JsonContextVariable
  """

  @type t :: %__MODULE__{type: String.t(), value: map | nil}

  defstruct [:type, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [type: {:string, :generic}, value: :map]
  end
end
