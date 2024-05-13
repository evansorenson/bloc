defmodule Jira.CustomFieldContextDefaultValueForgeMultiUserField do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueForgeMultiUserField
  """

  @type t :: %__MODULE__{accountIds: [String.t()], contextId: String.t(), type: String.t()}

  defstruct [:accountIds, :contextId, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [accountIds: [string: :generic], contextId: {:string, :generic}, type: {:string, :generic}]
  end
end
