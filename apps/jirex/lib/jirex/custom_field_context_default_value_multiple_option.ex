defmodule Jirex.CustomFieldContextDefaultValueMultipleOption do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueMultipleOption
  """

  @type t :: %__MODULE__{contextId: String.t(), optionIds: [String.t()], type: String.t()}

  defstruct [:contextId, :optionIds, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contextId: {:string, :generic}, optionIds: [string: :generic], type: {:string, :generic}]
  end
end
