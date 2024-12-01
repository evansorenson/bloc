defmodule Jirex.JqlFunctionPrecomputationUpdateBean do
  @moduledoc """
  Provides struct and type for a JqlFunctionPrecomputationUpdateBean
  """

  @type t :: %__MODULE__{error: String.t() | nil, id: String.t(), value: String.t() | nil}

  defstruct [:error, :id, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [error: {:string, :generic}, id: {:string, :generic}, value: {:string, :generic}]
  end
end
