defmodule Jira.JiraWorkflow do
  @moduledoc """
  Provides struct and type for a JiraWorkflow
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          isEditable: boolean | nil,
          name: String.t() | nil,
          scope: Jira.WorkflowScope.t() | nil,
          startPointLayout: Jira.WorkflowLayout.t() | nil,
          statuses: [Jira.WorkflowReferenceStatus.t()] | nil,
          taskId: String.t() | nil,
          transitions: [Jira.WorkflowTransitions.t()] | nil,
          usages: [Jira.ProjectIssueTypes.t()] | nil,
          version: Jira.DocumentVersion.t() | nil
        }

  defstruct [
    :description,
    :id,
    :isEditable,
    :name,
    :scope,
    :startPointLayout,
    :statuses,
    :taskId,
    :transitions,
    :usages,
    :version
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :generic},
      isEditable: :boolean,
      name: {:string, :generic},
      scope: {Jira.WorkflowScope, :t},
      startPointLayout: {Jira.WorkflowLayout, :t},
      statuses: [{Jira.WorkflowReferenceStatus, :t}],
      taskId: {:string, :generic},
      transitions: [{Jira.WorkflowTransitions, :t}],
      usages: [{Jira.ProjectIssueTypes, :t}],
      version: {Jira.DocumentVersion, :t}
    ]
  end
end
