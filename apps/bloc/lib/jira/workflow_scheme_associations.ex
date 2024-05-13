defmodule Jira.WorkflowSchemeAssociations do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeAssociations
  """

  @type t :: %__MODULE__{
          projectIds: [String.t()],
          workflowScheme: Jira.WorkflowSchemeAssociationsWorkflowScheme.t()
        }

  defstruct [:projectIds, :workflowScheme]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      projectIds: [string: :generic],
      workflowScheme: {Jira.WorkflowSchemeAssociationsWorkflowScheme, :t}
    ]
  end
end
