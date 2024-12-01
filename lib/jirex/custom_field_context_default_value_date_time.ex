defmodule Jirex.CustomFieldContextDefaultValueDateTime do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueDateTime
  """

  @type t :: %__MODULE__{dateTime: String.t() | nil, type: String.t(), useCurrent: boolean | nil}

  defstruct [:dateTime, :type, :useCurrent]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [dateTime: {:string, :generic}, type: {:string, :generic}, useCurrent: :boolean]
  end
end
