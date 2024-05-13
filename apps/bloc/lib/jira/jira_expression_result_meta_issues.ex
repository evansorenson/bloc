defmodule Jira.JiraExpressionResultMetaIssues do
  @moduledoc """
  Provides struct and type for a JiraExpressionResultMetaIssues
  """

  @type t :: %__MODULE__{jql: Jira.IssuesJqlMetaDataBean.t() | nil}

  defstruct [:jql]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [jql: {Jira.IssuesJqlMetaDataBean, :t}]
  end
end
