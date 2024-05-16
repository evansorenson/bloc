defmodule Jirex.SimpleApplicationPropertyBean do
  @moduledoc """
  Provides struct and type for a SimpleApplicationPropertyBean
  """

  @type t :: %__MODULE__{id: String.t() | nil, value: String.t() | nil}

  defstruct [:id, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: {:string, :generic}, value: {:string, :generic}]
  end
end
