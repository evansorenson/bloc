defmodule Jirex.WorkflowUpdateResponse do
  @moduledoc """
  Provides struct and type for a WorkflowUpdateResponse
  """

  @type t :: %__MODULE__{
          statuses: [Jirex.JiraWorkflowStatus.t()] | nil,
          taskId: String.t() | nil,
          workflows: [Jirex.JiraWorkflow.t()] | nil
        }

  defstruct [:statuses, :taskId, :workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      statuses: [{Jirex.JiraWorkflowStatus, :t}],
      taskId: {:string, :generic},
      workflows: [{Jirex.JiraWorkflow, :t}]
    ]
  end
end
