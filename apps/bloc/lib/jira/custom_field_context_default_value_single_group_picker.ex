defmodule Jira.CustomFieldContextDefaultValueSingleGroupPicker do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueSingleGroupPicker
  """

  @type t :: %__MODULE__{contextId: String.t(), groupId: String.t(), type: String.t()}

  defstruct [:contextId, :groupId, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contextId: {:string, :generic}, groupId: {:string, :generic}, type: {:string, :generic}]
  end
end
