defmodule Jira.LinkIssueRequestJsonBean do
  @moduledoc """
  Provides struct and type for a LinkIssueRequestJsonBean
  """

  @type t :: %__MODULE__{
          comment: Jira.Comment.t() | nil,
          inwardIssue: Jira.LinkedIssue.t(),
          outwardIssue: Jira.LinkedIssue.t(),
          type: Jira.IssueLinkType.t()
        }

  defstruct [:comment, :inwardIssue, :outwardIssue, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      comment: {Jira.Comment, :t},
      inwardIssue: {Jira.LinkedIssue, :t},
      outwardIssue: {Jira.LinkedIssue, :t},
      type: {Jira.IssueLinkType, :t}
    ]
  end
end
