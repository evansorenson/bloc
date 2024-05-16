defmodule Jirex.JiraWorkflow do
  @moduledoc """
  Provides struct and type for a JiraWorkflow
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          isEditable: boolean | nil,
          name: String.t() | nil,
          scope: Jirex.WorkflowScope.t() | nil,
          startPointLayout: Jirex.WorkflowLayout.t() | nil,
          statuses: [Jirex.WorkflowReferenceStatus.t()] | nil,
          taskId: String.t() | nil,
          transitions: [Jirex.WorkflowTransitions.t()] | nil,
          usages: [Jirex.ProjectIssueTypes.t()] | nil,
          version: Jirex.DocumentVersion.t() | nil
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
      scope: {Jirex.WorkflowScope, :t},
      startPointLayout: {Jirex.WorkflowLayout, :t},
      statuses: [{Jirex.WorkflowReferenceStatus, :t}],
      taskId: {:string, :generic},
      transitions: [{Jirex.WorkflowTransitions, :t}],
      usages: [{Jirex.ProjectIssueTypes, :t}],
      version: {Jirex.DocumentVersion, :t}
    ]
  end
end
