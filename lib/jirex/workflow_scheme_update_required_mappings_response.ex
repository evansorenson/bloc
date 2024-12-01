defmodule Jirex.WorkflowSchemeUpdateRequiredMappingsResponse do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeUpdateRequiredMappingsResponse
  """

  @type t :: %__MODULE__{
          statusMappingsByIssueTypes: [Jirex.RequiredMappingByIssueType.t()] | nil,
          statusMappingsByWorkflows: [Jirex.RequiredMappingByWorkflows.t()] | nil,
          statuses: [Jirex.StatusMetadata.t()] | nil,
          statusesPerWorkflow: [Jirex.StatusesPerWorkflow.t()] | nil
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
      statusMappingsByIssueTypes: [{Jirex.RequiredMappingByIssueType, :t}],
      statusMappingsByWorkflows: [{Jirex.RequiredMappingByWorkflows, :t}],
      statuses: [{Jirex.StatusMetadata, :t}],
      statusesPerWorkflow: [{Jirex.StatusesPerWorkflow, :t}]
    ]
  end
end
