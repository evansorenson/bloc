defmodule Jirex.CustomFieldContextDefaultValueForgeMultiGroupField do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueForgeMultiGroupField
  """

  @type t :: %__MODULE__{contextId: String.t(), groupIds: [String.t()], type: String.t()}

  defstruct [:contextId, :groupIds, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contextId: {:string, :generic}, groupIds: [string: :generic], type: {:string, :generic}]
  end
end
