defmodule Jirex.UpdatePrioritySchemeRequestBean do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeRequestBean
  """

  @type t :: %__MODULE__{
          defaultPriorityId: integer | nil,
          description: String.t() | nil,
          mappings: Jirex.UpdatePrioritySchemeRequestBeanMappings.t() | nil,
          name: String.t() | nil,
          priorities: Jirex.UpdatePrioritySchemeRequestBeanPriorities.t() | nil,
          projects: Jirex.UpdatePrioritySchemeRequestBeanProjects.t() | nil
        }

  defstruct [:defaultPriorityId, :description, :mappings, :name, :priorities, :projects]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultPriorityId: :integer,
      description: {:string, :generic},
      mappings: {Jirex.UpdatePrioritySchemeRequestBeanMappings, :t},
      name: {:string, :generic},
      priorities: {Jirex.UpdatePrioritySchemeRequestBeanPriorities, :t},
      projects: {Jirex.UpdatePrioritySchemeRequestBeanProjects, :t}
    ]
  end
end
