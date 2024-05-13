defmodule Jira.WorkflowReadResponse do
  @moduledoc """
  Provides struct and type for a WorkflowReadResponse
  """

  @type t :: %__MODULE__{
          statuses: [Jira.JiraWorkflowStatus.t()] | nil,
          workflows: [Jira.JiraWorkflow.t()] | nil
        }

  defstruct [:statuses, :workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [statuses: [{Jira.JiraWorkflowStatus, :t}], workflows: [{Jira.JiraWorkflow, :t}]]
  end
end
