defmodule Jira.CreatedIssues do
  @moduledoc """
  Provides struct and type for a CreatedIssues
  """

  @type t :: %__MODULE__{
          errors: [Jira.BulkOperationErrorResult.t()] | nil,
          issues: [Jira.CreatedIssue.t()] | nil
        }

  defstruct [:errors, :issues]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errors: [{Jira.BulkOperationErrorResult, :t}], issues: [{Jira.CreatedIssue, :t}]]
  end
end
