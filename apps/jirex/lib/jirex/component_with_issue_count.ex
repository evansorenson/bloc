defmodule Jirex.ComponentWithIssueCount do
  @moduledoc """
  Provides struct and type for a ComponentWithIssueCount
  """

  @type t :: %__MODULE__{
          assignee: Jirex.ComponentWithIssueCountAssignee.t() | nil,
          assigneeType: String.t() | nil,
          description: String.t() | nil,
          id: String.t() | nil,
          isAssigneeTypeValid: boolean | nil,
          issueCount: integer | nil,
          lead: Jirex.ComponentWithIssueCountLead.t() | nil,
          name: String.t() | nil,
          project: String.t() | nil,
          projectId: integer | nil,
          realAssignee: Jirex.ComponentWithIssueCountRealAssignee.t() | nil,
          realAssigneeType: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [
    :assignee,
    :assigneeType,
    :description,
    :id,
    :isAssigneeTypeValid,
    :issueCount,
    :lead,
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
      assignee: {Jirex.ComponentWithIssueCountAssignee, :t},
      assigneeType: {:enum, ["PROJECT_DEFAULT", "COMPONENT_LEAD", "PROJECT_LEAD", "UNASSIGNED"]},
      description: {:string, :generic},
      id: {:string, :generic},
      isAssigneeTypeValid: :boolean,
      issueCount: :integer,
      lead: {Jirex.ComponentWithIssueCountLead, :t},
      name: {:string, :generic},
      project: {:string, :generic},
      projectId: :integer,
      realAssignee: {Jirex.ComponentWithIssueCountRealAssignee, :t},
      realAssigneeType:
        {:enum, ["PROJECT_DEFAULT", "COMPONENT_LEAD", "PROJECT_LEAD", "UNASSIGNED"]},
      self: {:string, :uri}
    ]
  end
end
