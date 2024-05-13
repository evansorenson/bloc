defmodule Jira.UpdatePrioritySchemeRequestBean do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeRequestBean
  """

  @type t :: %__MODULE__{
          defaultPriorityId: integer | nil,
          description: String.t() | nil,
          mappings: Jira.UpdatePrioritySchemeRequestBeanMappings.t() | nil,
          name: String.t() | nil,
          priorities: Jira.UpdatePrioritySchemeRequestBeanPriorities.t() | nil,
          projects: Jira.UpdatePrioritySchemeRequestBeanProjects.t() | nil
        }

  defstruct [:defaultPriorityId, :description, :mappings, :name, :priorities, :projects]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultPriorityId: :integer,
      description: {:string, :generic},
      mappings: {Jira.UpdatePrioritySchemeRequestBeanMappings, :t},
      name: {:string, :generic},
      priorities: {Jira.UpdatePrioritySchemeRequestBeanPriorities, :t},
      projects: {Jira.UpdatePrioritySchemeRequestBeanProjects, :t}
    ]
  end
end
