defmodule Jira.JiraExpressionEvalRequestBeanContext do
  @moduledoc """
  Provides struct and type for a JiraExpressionEvalRequestBeanContext
  """

  @type t :: %__MODULE__{
          board: integer | nil,
          custom:
            [
              Jira.IssueContextVariable.t()
              | Jira.JsonContextVariable.t()
              | Jira.UserContextVariable.t()
            ]
            | nil,
          customerRequest: integer | nil,
          issue: Jira.JiraExpressionEvalRequestBeanContextIssue.t() | nil,
          issues: Jira.JiraExpressionEvalRequestBeanContextIssues.t() | nil,
          project: Jira.JiraExpressionEvalRequestBeanContextProject.t() | nil,
          serviceDesk: integer | nil,
          sprint: integer | nil
        }

  defstruct [:board, :custom, :customerRequest, :issue, :issues, :project, :serviceDesk, :sprint]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      board: :integer,
      custom: [
        union: [
          {Jira.IssueContextVariable, :t},
          {Jira.JsonContextVariable, :t},
          {Jira.UserContextVariable, :t}
        ]
      ],
      customerRequest: :integer,
      issue: {Jira.JiraExpressionEvalRequestBeanContextIssue, :t},
      issues: {Jira.JiraExpressionEvalRequestBeanContextIssues, :t},
      project: {Jira.JiraExpressionEvalRequestBeanContextProject, :t},
      serviceDesk: :integer,
      sprint: :integer
    ]
  end
end
