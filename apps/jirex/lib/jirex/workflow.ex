defmodule Jirex.Workflow do
  @moduledoc """
  Provides struct and type for a Workflow
  """

  @type t :: %__MODULE__{
          created: DateTime.t() | nil,
          description: String.t(),
          hasDraftWorkflow: boolean | nil,
          id: Jirex.PublishedWorkflowId.t(),
          isDefault: boolean | nil,
          operations: Jirex.WorkflowOperations.t() | nil,
          projects: [Jirex.ProjectDetails.t()] | nil,
          schemes: [Jirex.WorkflowSchemeIdName.t()] | nil,
          statuses: [Jirex.WorkflowStatus.t()] | nil,
          transitions: [Jirex.Transition.t()] | nil,
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
      id: {Jirex.PublishedWorkflowId, :t},
      isDefault: :boolean,
      operations: {Jirex.WorkflowOperations, :t},
      projects: [{Jirex.ProjectDetails, :t}],
      schemes: [{Jirex.WorkflowSchemeIdName, :t}],
      statuses: [{Jirex.WorkflowStatus, :t}],
      transitions: [{Jirex.Transition, :t}],
      updated: {:string, :date_time}
    ]
  end
end
