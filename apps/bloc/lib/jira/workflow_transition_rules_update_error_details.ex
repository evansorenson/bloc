defmodule Jira.WorkflowTransitionRulesUpdateErrorDetails do
  @moduledoc """
  Provides struct and type for a WorkflowTransitionRulesUpdateErrorDetails
  """

  @type t :: %__MODULE__{
          ruleUpdateErrors: Jira.WorkflowTransitionRulesUpdateErrorDetailsRuleUpdateErrors.t(),
          updateErrors: [String.t()],
          workflowId: Jira.WorkflowId.t()
        }

  defstruct [:ruleUpdateErrors, :updateErrors, :workflowId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      ruleUpdateErrors: {Jira.WorkflowTransitionRulesUpdateErrorDetailsRuleUpdateErrors, :t},
      updateErrors: [string: :generic],
      workflowId: {Jira.WorkflowId, :t}
    ]
  end
end
