defmodule Jira.IssueTypeSchemeProjects do
  @moduledoc """
  Provides struct and type for a IssueTypeSchemeProjects
  """

  @type t :: %__MODULE__{
          issueTypeScheme: Jira.IssueTypeSchemeProjectsIssueTypeScheme.t(),
          projectIds: [String.t()]
        }

  defstruct [:issueTypeScheme, :projectIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issueTypeScheme: {Jira.IssueTypeSchemeProjectsIssueTypeScheme, :t},
      projectIds: [string: :generic]
    ]
  end
end
