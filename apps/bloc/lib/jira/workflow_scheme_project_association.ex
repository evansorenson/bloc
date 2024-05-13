defmodule Jira.WorkflowSchemeProjectAssociation do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeProjectAssociation
  """

  @type t :: %__MODULE__{projectId: String.t(), workflowSchemeId: String.t() | nil}

  defstruct [:projectId, :workflowSchemeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [projectId: {:string, :generic}, workflowSchemeId: {:string, :generic}]
  end
end
