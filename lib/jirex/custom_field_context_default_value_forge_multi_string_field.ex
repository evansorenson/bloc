defmodule Jirex.CustomFieldContextDefaultValueForgeMultiStringField do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueForgeMultiStringField
  """

  @type t :: %__MODULE__{type: String.t(), values: [String.t()] | nil}

  defstruct [:type, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [type: {:string, :generic}, values: [string: :generic]]
  end
end
