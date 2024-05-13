defmodule Jira.WorkflowSchemeReadResponse do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeReadResponse
  """

  @type t :: %__MODULE__{
          defaultWorkflow: Jira.WorkflowMetadataRestModel.t() | nil,
          description: String.t() | nil,
          id: String.t(),
          name: String.t(),
          projectIdsUsingScheme: [String.t()],
          scope: Jira.WorkflowScope.t(),
          taskId: String.t() | nil,
          version: Jira.DocumentVersion.t(),
          workflowsForIssueTypes: [Jira.WorkflowMetadataAndIssueTypeRestModel.t()]
        }

  defstruct [
    :defaultWorkflow,
    :description,
    :id,
    :name,
    :projectIdsUsingScheme,
    :scope,
    :taskId,
    :version,
    :workflowsForIssueTypes
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultWorkflow: {Jira.WorkflowMetadataRestModel, :t},
      description: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      projectIdsUsingScheme: [string: :generic],
      scope: {Jira.WorkflowScope, :t},
      taskId: {:string, :generic},
      version: {Jira.DocumentVersion, :t},
      workflowsForIssueTypes: [{Jira.WorkflowMetadataAndIssueTypeRestModel, :t}]
    ]
  end
end
