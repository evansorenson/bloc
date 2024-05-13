defmodule Jira.OldToNewSecurityLevelMappingsBean do
  @moduledoc """
  Provides struct and type for a OldToNewSecurityLevelMappingsBean
  """

  @type t :: %__MODULE__{newLevelId: String.t(), oldLevelId: String.t()}

  defstruct [:newLevelId, :oldLevelId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [newLevelId: {:string, :generic}, oldLevelId: {:string, :generic}]
  end
end
