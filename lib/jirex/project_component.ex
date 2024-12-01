defmodule Jirex.ProjectComponent do
  @moduledoc """
  Provides struct and type for a ProjectComponent
  """

  @type t :: %__MODULE__{
          ari: String.t() | nil,
          assignee: Jirex.ProjectComponentAssignee.t() | nil,
          assigneeType: String.t() | nil,
          description: String.t() | nil,
          id: String.t() | nil,
          isAssigneeTypeValid: boolean | nil,
          lead: Jirex.ProjectComponentLead.t() | nil,
          leadAccountId: String.t() | nil,
          leadUserName: String.t() | nil,
          metadata: Jirex.ProjectComponentMetadata.t() | nil,
          name: String.t() | nil,
          project: String.t() | nil,
          projectId: integer | nil,
          realAssignee: Jirex.ProjectComponentRealAssignee.t() | nil,
          realAssigneeType: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [
    :ari,
    :assignee,
    :assigneeType,
    :description,
    :id,
    :isAssigneeTypeValid,
    :lead,
    :leadAccountId,
    :leadUserName,
    :metadata,
    :name,
    :project,
    :projectId,
    :realAssignee,
    :realAssigneeType,
    :self
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      ari: {:string, :generic},
      assignee: {Jirex.ProjectComponentAssignee, :t},
      assigneeType: {:enum, ["PROJECT_DEFAULT", "COMPONENT_LEAD", "PROJECT_LEAD", "UNASSIGNED"]},
      description: {:string, :generic},
      id: {:string, :generic},
      isAssigneeTypeValid: :boolean,
      lead: {Jirex.ProjectComponentLead, :t},
      leadAccountId: {:string, :generic},
      leadUserName: {:string, :generic},
      metadata: {Jirex.ProjectComponentMetadata, :t},
      name: {:string, :generic},
      project: {:string, :generic},
      projectId: :integer,
      realAssignee: {Jirex.ProjectComponentRealAssignee, :t},
      realAssigneeType:
        {:enum, ["PROJECT_DEFAULT", "COMPONENT_LEAD", "PROJECT_LEAD", "UNASSIGNED"]},
      self: {:string, :uri}
    ]
  end
end
