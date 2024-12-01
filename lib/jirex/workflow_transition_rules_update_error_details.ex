defmodule Jirex.WorkflowTransitionRulesUpdateErrorDetails do
  @moduledoc """
  Provides struct and type for a WorkflowTransitionRulesUpdateErrorDetails
  """

  @type t :: %__MODULE__{
          ruleUpdateErrors: Jirex.WorkflowTransitionRulesUpdateErrorDetailsRuleUpdateErrors.t(),
          updateErrors: [String.t()],
          workflowId: Jirex.WorkflowId.t()
        }

  defstruct [:ruleUpdateErrors, :updateErrors, :workflowId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      ruleUpdateErrors: {Jirex.WorkflowTransitionRulesUpdateErrorDetailsRuleUpdateErrors, :t},
      updateErrors: [string: :generic],
      workflowId: {Jirex.WorkflowId, :t}
    ]
  end
end
