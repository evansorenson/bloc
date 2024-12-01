defmodule Jirex.WorkflowSchemeReadResponse do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeReadResponse
  """

  @type t :: %__MODULE__{
          defaultWorkflow: Jirex.WorkflowMetadataRestModel.t() | nil,
          description: String.t() | nil,
          id: String.t(),
          name: String.t(),
          projectIdsUsingScheme: [String.t()],
          scope: Jirex.WorkflowScope.t(),
          taskId: String.t() | nil,
          version: Jirex.DocumentVersion.t(),
          workflowsForIssueTypes: [Jirex.WorkflowMetadataAndIssueTypeRestModel.t()]
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
      defaultWorkflow: {Jirex.WorkflowMetadataRestModel, :t},
      description: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      projectIdsUsingScheme: [string: :generic],
      scope: {Jirex.WorkflowScope, :t},
      taskId: {:string, :generic},
      version: {Jirex.DocumentVersion, :t},
      workflowsForIssueTypes: [{Jirex.WorkflowMetadataAndIssueTypeRestModel, :t}]
    ]
  end
end
