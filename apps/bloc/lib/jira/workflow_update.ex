defmodule Jira.WorkflowUpdate do
  @moduledoc """
  Provides struct and type for a WorkflowUpdate
  """

  @type t :: %__MODULE__{
          defaultStatusMappings: [Jira.StatusMigration.t()] | nil,
          description: String.t() | nil,
          id: String.t(),
          startPointLayout: Jira.WorkflowLayout.t() | nil,
          statusMappings: [Jira.StatusMappingDTO.t()] | nil,
          statuses: [Jira.StatusLayoutUpdate.t()],
          transitions: [Jira.TransitionUpdateDTO.t()],
          version: Jira.DocumentVersion.t()
        }

  defstruct [
    :defaultStatusMappings,
    :description,
    :id,
    :startPointLayout,
    :statusMappings,
    :statuses,
    :transitions,
    :version
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultStatusMappings: [{Jira.StatusMigration, :t}],
      description: {:string, :generic},
      id: {:string, :generic},
      startPointLayout: {Jira.WorkflowLayout, :t},
      statusMappings: [{Jira.StatusMappingDTO, :t}],
      statuses: [{Jira.StatusLayoutUpdate, :t}],
      transitions: [{Jira.TransitionUpdateDTO, :t}],
      version: {Jira.DocumentVersion, :t}
    ]
  end
end
