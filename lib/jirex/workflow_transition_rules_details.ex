defmodule Jirex.WorkflowTransitionRulesDetails do
  @moduledoc """
  Provides struct and type for a WorkflowTransitionRulesDetails
  """

  @type t :: %__MODULE__{workflowId: Jirex.WorkflowId.t(), workflowRuleIds: [String.t()]}

  defstruct [:workflowId, :workflowRuleIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [workflowId: {Jirex.WorkflowId, :t}, workflowRuleIds: [string: :generic]]
  end
end
