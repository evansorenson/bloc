defmodule Jira.CustomFieldContextDefaultValueForgeStringField do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueForgeStringField
  """

  @type t :: %__MODULE__{contextId: String.t(), text: String.t() | nil, type: String.t()}

  defstruct [:contextId, :text, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contextId: {:string, :generic}, text: {:string, :generic}, type: {:string, :generic}]
  end
end
