defmodule Jirex.JiraExpressionEvalRequestBeanContextIssues do
  @moduledoc """
  Provides struct and type for a JiraExpressionEvalRequestBeanContextIssues
  """

  @type t :: %__MODULE__{jql: Jirex.JiraExpressionEvalRequestBeanContextIssuesJql.t() | nil}

  defstruct [:jql]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [jql: {Jirex.JiraExpressionEvalRequestBeanContextIssuesJql, :t}]
  end
end
