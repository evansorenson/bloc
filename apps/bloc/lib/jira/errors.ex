defmodule Jira.Errors do
  @moduledoc """
  Provides struct and type for a Errors
  """

  @type t :: %__MODULE__{
          issueIsSubtask: Jira.Error.t() | nil,
          issuesInArchivedProjects: Jira.Error.t() | nil,
          issuesInUnlicensedProjects: Jira.Error.t() | nil,
          issuesNotFound: Jira.Error.t() | nil
        }

  defstruct [
    :issueIsSubtask,
    :issuesInArchivedProjects,
    :issuesInUnlicensedProjects,
    :issuesNotFound
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issueIsSubtask: {Jira.Error, :t},
      issuesInArchivedProjects: {Jira.Error, :t},
      issuesInUnlicensedProjects: {Jira.Error, :t},
      issuesNotFound: {Jira.Error, :t}
    ]
  end
end
