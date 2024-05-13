defmodule Jira.WorkflowAssociationStatusMapping do
  @moduledoc """
  Provides struct and type for a WorkflowAssociationStatusMapping
  """

  @type t :: %__MODULE__{newStatusId: String.t(), oldStatusId: String.t()}

  defstruct [:newStatusId, :oldStatusId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [newStatusId: {:string, :generic}, oldStatusId: {:string, :generic}]
  end
end
