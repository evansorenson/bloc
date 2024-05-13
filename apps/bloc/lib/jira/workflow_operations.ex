defmodule Jira.WorkflowOperations do
  @moduledoc """
  Provides struct and type for a WorkflowOperations
  """

  @type t :: %__MODULE__{canDelete: boolean, canEdit: boolean}

  defstruct [:canDelete, :canEdit]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [canDelete: :boolean, canEdit: :boolean]
  end
end
