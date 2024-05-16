defmodule Jirex.WarningCollection do
  @moduledoc """
  Provides struct and type for a WarningCollection
  """

  @type t :: %__MODULE__{warnings: [String.t()] | nil}

  defstruct [:warnings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [warnings: [string: :generic]]
  end
end
