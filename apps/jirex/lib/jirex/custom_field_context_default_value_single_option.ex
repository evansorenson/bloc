defmodule Jirex.CustomFieldContextDefaultValueSingleOption do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueSingleOption
  """

  @type t :: %__MODULE__{contextId: String.t(), optionId: String.t(), type: String.t()}

  defstruct [:contextId, :optionId, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contextId: {:string, :generic}, optionId: {:string, :generic}, type: {:string, :generic}]
  end
end
