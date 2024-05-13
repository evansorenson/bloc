defmodule Jira.ProjectIssueTypeHierarchy do
  @moduledoc """
  Provides struct and type for a ProjectIssueTypeHierarchy
  """

  @type t :: %__MODULE__{
          hierarchy: [Jira.ProjectIssueTypesHierarchyLevel.t()] | nil,
          projectId: integer | nil
        }

  defstruct [:hierarchy, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [hierarchy: [{Jira.ProjectIssueTypesHierarchyLevel, :t}], projectId: :integer]
  end
end
