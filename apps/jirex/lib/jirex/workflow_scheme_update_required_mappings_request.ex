defmodule Jirex.WorkflowSchemeUpdateRequiredMappingsRequest do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeUpdateRequiredMappingsRequest
  """

  @type t :: %__MODULE__{
          defaultWorkflowId: String.t() | nil,
          id: String.t(),
          workflowsForIssueTypes: [Jirex.WorkflowSchemeAssociation.t()]
        }

  defstruct [:defaultWorkflowId, :id, :workflowsForIssueTypes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultWorkflowId: {:string, :generic},
      id: {:string, :generic},
      workflowsForIssueTypes: [{Jirex.WorkflowSchemeAssociation, :t}]
    ]
  end
end
