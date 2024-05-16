defmodule Jirex.IssueTypeScreenSchemesProjects do
  @moduledoc """
  Provides struct and type for a IssueTypeScreenSchemesProjects
  """

  @type t :: %__MODULE__{
          issueTypeScreenScheme: Jirex.IssueTypeScreenSchemesProjectsIssueTypeScreenScheme.t(),
          projectIds: [String.t()]
        }

  defstruct [:issueTypeScreenScheme, :projectIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issueTypeScreenScheme: {Jirex.IssueTypeScreenSchemesProjectsIssueTypeScreenScheme, :t},
      projectIds: [string: :generic]
    ]
  end
end
