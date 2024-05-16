defmodule Jirex.CustomFieldContextDefaultValueForgeObjectField do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueForgeObjectField
  """

  @type t :: %__MODULE__{object: map | nil, type: String.t()}

  defstruct [:object, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [object: :map, type: {:string, :generic}]
  end
end
