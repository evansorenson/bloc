defmodule Jirex.IssueTypeSchemeProjects do
  @moduledoc """
  Provides struct and type for a IssueTypeSchemeProjects
  """

  @type t :: %__MODULE__{
          issueTypeScheme: Jirex.IssueTypeSchemeProjectsIssueTypeScheme.t(),
          projectIds: [String.t()]
        }

  defstruct [:issueTypeScheme, :projectIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issueTypeScheme: {Jirex.IssueTypeSchemeProjectsIssueTypeScheme, :t},
      projectIds: [string: :generic]
    ]
  end
end
