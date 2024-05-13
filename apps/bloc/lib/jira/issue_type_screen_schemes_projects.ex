defmodule Jira.IssueTypeScreenSchemesProjects do
  @moduledoc """
  Provides struct and type for a IssueTypeScreenSchemesProjects
  """

  @type t :: %__MODULE__{
          issueTypeScreenScheme: Jira.IssueTypeScreenSchemesProjectsIssueTypeScreenScheme.t(),
          projectIds: [String.t()]
        }

  defstruct [:issueTypeScreenScheme, :projectIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issueTypeScreenScheme: {Jira.IssueTypeScreenSchemesProjectsIssueTypeScreenScheme, :t},
      projectIds: [string: :generic]
    ]
  end
end
