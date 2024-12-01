defmodule Jirex.CustomFieldContextDefaultValueForgeNumberField do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueForgeNumberField
  """

  @type t :: %__MODULE__{contextId: String.t(), number: number, type: String.t()}

  defstruct [:contextId, :number, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contextId: {:string, :generic}, number: :number, type: {:string, :generic}]
  end
end
