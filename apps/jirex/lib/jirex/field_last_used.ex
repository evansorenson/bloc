defmodule Jirex.FieldLastUsed do
  @moduledoc """
  Provides struct and type for a FieldLastUsed
  """

  @type t :: %__MODULE__{type: String.t() | nil, value: DateTime.t() | nil}

  defstruct [:type, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [type: {:enum, ["TRACKED", "NOT_TRACKED", "NO_INFORMATION"]}, value: {:string, :date_time}]
  end
end
