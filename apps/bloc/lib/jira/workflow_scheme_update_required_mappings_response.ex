defmodule Jira.WorkflowSchemeUpdateRequiredMappingsResponse do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeUpdateRequiredMappingsResponse
  """

  @type t :: %__MODULE__{
          statusMappingsByIssueTypes: [Jira.RequiredMappingByIssueType.t()] | nil,
          statusMappingsByWorkflows: [Jira.RequiredMappingByWorkflows.t()] | nil,
          statuses: [Jira.StatusMetadata.t()] | nil,
          statusesPerWorkflow: [Jira.StatusesPerWorkflow.t()] | nil
        }

  defstruct [
    :statusMappingsByIssueTypes,
    :statusMappingsByWorkflows,
    :statuses,
    :statusesPerWorkflow
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      statusMappingsByIssueTypes: [{Jira.RequiredMappingByIssueType, :t}],
      statusMappingsByWorkflows: [{Jira.RequiredMappingByWorkflows, :t}],
      statuses: [{Jira.StatusMetadata, :t}],
      statusesPerWorkflow: [{Jira.StatusesPerWorkflow, :t}]
    ]
  end
end
