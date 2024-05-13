defmodule Jira.WorkflowSchemeUpdateRequest do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeUpdateRequest
  """

  @type t :: %__MODULE__{
          defaultWorkflowId: String.t() | nil,
          description: String.t(),
          id: String.t(),
          name: String.t(),
          statusMappingsByIssueTypeOverride: [Jira.MappingsByIssueTypeOverride.t()] | nil,
          statusMappingsByWorkflows: [Jira.MappingsByWorkflow.t()] | nil,
          version: Jira.DocumentVersion.t(),
          workflowsForIssueTypes: [Jira.WorkflowSchemeAssociation.t()] | nil
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
      statusMappingsByIssueTypeOverride: [{Jira.MappingsByIssueTypeOverride, :t}],
      statusMappingsByWorkflows: [{Jira.MappingsByWorkflow, :t}],
      version: {Jira.DocumentVersion, :t},
      workflowsForIssueTypes: [{Jira.WorkflowSchemeAssociation, :t}]
    ]
  end
end
