defmodule Jirex.WorkflowSchemeUpdateRequest do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeUpdateRequest
  """

  @type t :: %__MODULE__{
          defaultWorkflowId: String.t() | nil,
          description: String.t(),
          id: String.t(),
          name: String.t(),
          statusMappingsByIssueTypeOverride: [Jirex.MappingsByIssueTypeOverride.t()] | nil,
          statusMappingsByWorkflows: [Jirex.MappingsByWorkflow.t()] | nil,
          version: Jirex.DocumentVersion.t(),
          workflowsForIssueTypes: [Jirex.WorkflowSchemeAssociation.t()] | nil
        }

  defstruct [
    :defaultWorkflowId,
    :description,
    :id,
    :name,
    :statusMappingsByIssueTypeOverride,
    :statusMappingsByWorkflows,
    :version,
    :workflowsForIssueTypes
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultWorkflowId: {:string, :generic},
      description: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      statusMappingsByIssueTypeOverride: [{Jirex.MappingsByIssueTypeOverride, :t}],
      statusMappingsByWorkflows: [{Jirex.MappingsByWorkflow, :t}],
      version: {Jirex.DocumentVersion, :t},
      workflowsForIssueTypes: [{Jirex.WorkflowSchemeAssociation, :t}]
    ]
  end
end
