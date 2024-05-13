defmodule Jira.WorkflowUpdateResponse do
  @moduledoc """
  Provides struct and type for a WorkflowUpdateResponse
  """

  @type t :: %__MODULE__{
          statuses: [Jira.JiraWorkflowStatus.t()] | nil,
          taskId: String.t() | nil,
          workflows: [Jira.JiraWorkflow.t()] | nil
        }

  defstruct [:statuses, :taskId, :workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      statuses: [{Jira.JiraWorkflowStatus, :t}],
      taskId: {:string, :generic},
      workflows: [{Jira.JiraWorkflow, :t}]
    ]
  end
end
