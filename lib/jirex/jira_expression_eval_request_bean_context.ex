defmodule Jirex.JiraExpressionEvalRequestBeanContext do
  @moduledoc """
  Provides struct and type for a JiraExpressionEvalRequestBeanContext
  """

  @type t :: %__MODULE__{
          board: integer | nil,
          custom:
            [
              Jirex.IssueContextVariable.t()
              | Jirex.JsonContextVariable.t()
              | Jirex.UserContextVariable.t()
            ]
            | nil,
          customerRequest: integer | nil,
          issue: Jirex.JiraExpressionEvalRequestBeanContextIssue.t() | nil,
          issues: Jirex.JiraExpressionEvalRequestBeanContextIssues.t() | nil,
          project: Jirex.JiraExpressionEvalRequestBeanContextProject.t() | nil,
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
          {Jirex.IssueContextVariable, :t},
          {Jirex.JsonContextVariable, :t},
          {Jirex.UserContextVariable, :t}
        ]
      ],
      customerRequest: :integer,
      issue: {Jirex.JiraExpressionEvalRequestBeanContextIssue, :t},
      issues: {Jirex.JiraExpressionEvalRequestBeanContextIssues, :t},
      project: {Jirex.JiraExpressionEvalRequestBeanContextProject, :t},
      serviceDesk: :integer,
      sprint: :integer
    ]
  end
end
