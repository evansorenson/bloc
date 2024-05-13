defmodule Jira.Workflow do
  @moduledoc """
  Provides struct and type for a Workflow
  """

  @type t :: %__MODULE__{
          created: DateTime.t() | nil,
          description: String.t(),
          hasDraftWorkflow: boolean | nil,
          id: Jira.PublishedWorkflowId.t(),
          isDefault: boolean | nil,
          operations: Jira.WorkflowOperations.t() | nil,
          projects: [Jira.ProjectDetails.t()] | nil,
          schemes: [Jira.WorkflowSchemeIdName.t()] | nil,
          statuses: [Jira.WorkflowStatus.t()] | nil,
          transitions: [Jira.Transition.t()] | nil,
          updated: DateTime.t() | nil
        }

  defstruct [
    :created,
    :description,
    :hasDraftWorkflow,
    :id,
    :isDefault,
    :operations,
    :projects,
    :schemes,
    :statuses,
    :transitions,
    :updated
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created: {:string, :date_time},
      description: {:string, :generic},
      hasDraftWorkflow: :boolean,
      id: {Jira.PublishedWorkflowId, :t},
      isDefault: :boolean,
      operations: {Jira.WorkflowOperations, :t},
      projects: [{Jira.ProjectDetails, :t}],
      schemes: [{Jira.WorkflowSchemeIdName, :t}],
      statuses: [{Jira.WorkflowStatus, :t}],
      transitions: [{Jira.Transition, :t}],
      updated: {:string, :date_time}
    ]
  end
end
