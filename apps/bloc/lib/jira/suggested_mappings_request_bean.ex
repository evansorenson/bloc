defmodule Jira.SuggestedMappingsRequestBean do
  @moduledoc """
  Provides struct and type for a SuggestedMappingsRequestBean
  """

  @type t :: %__MODULE__{
          maxResults: integer | nil,
          priorities: Jira.SuggestedMappingsRequestBeanPriorities.t() | nil,
          projects: Jira.SuggestedMappingsRequestBeanProjects.t() | nil,
          schemeId: integer | nil,
          startAt: integer | nil
        }

  defstruct [:maxResults, :priorities, :projects, :schemeId, :startAt]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      maxResults: :integer,
      priorities: {Jira.SuggestedMappingsRequestBeanPriorities, :t},
      projects: {Jira.SuggestedMappingsRequestBeanProjects, :t},
      schemeId: :integer,
      startAt: :integer
    ]
  end
end
