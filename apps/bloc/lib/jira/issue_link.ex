defmodule Jira.IssueLink do
  @moduledoc """
  Provides struct and type for a IssueLink
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          inwardIssue: Jira.IssueLinkInwardIssue.t(),
          outwardIssue: Jira.IssueLinkOutwardIssue.t(),
          self: String.t() | nil,
          type: Jira.IssueLinkType.t()
        }

  defstruct [:id, :inwardIssue, :outwardIssue, :self, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      inwardIssue: {Jira.IssueLinkInwardIssue, :t},
      outwardIssue: {Jira.IssueLinkOutwardIssue, :t},
      self: {:string, :uri},
      type: {Jira.IssueLinkType, :t}
    ]
  end
end
