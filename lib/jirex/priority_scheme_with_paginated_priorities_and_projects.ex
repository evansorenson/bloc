defmodule Jirex.PrioritySchemeWithPaginatedPrioritiesAndProjects do
  @moduledoc """
  Provides struct and type for a PrioritySchemeWithPaginatedPrioritiesAndProjects
  """

  @type t :: %__MODULE__{
          default: boolean | nil,
          defaultPriorityId: String.t() | nil,
          description: String.t() | nil,
          id: String.t(),
          isDefault: boolean | nil,
          name: String.t(),
          priorities: Jirex.PrioritySchemeWithPaginatedPrioritiesAndProjectsPriorities.t() | nil,
          projects: Jirex.PrioritySchemeWithPaginatedPrioritiesAndProjectsProjects.t() | nil,
          self: String.t() | nil
        }

  defstruct [
    :default,
    :defaultPriorityId,
    :description,
    :id,
    :isDefault,
    :name,
    :priorities,
    :projects,
    :self
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      default: :boolean,
      defaultPriorityId: {:string, :generic},
      description: {:string, :generic},
      id: {:string, :generic},
      isDefault: :boolean,
      name: {:string, :generic},
      priorities: {Jirex.PrioritySchemeWithPaginatedPrioritiesAndProjectsPriorities, :t},
      projects: {Jirex.PrioritySchemeWithPaginatedPrioritiesAndProjectsProjects, :t},
      self: {:string, :generic}
    ]
  end
end
