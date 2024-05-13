defmodule Jira.WorkflowRules do
  @moduledoc """
  Provides struct and type for a WorkflowRules
  """

  @type t :: %__MODULE__{
          conditionsTree:
            Jira.WorkflowCompoundCondition.t() | Jira.WorkflowSimpleCondition.t() | nil,
          postFunctions: [Jira.WorkflowTransitionRule.t()] | nil,
          validators: [Jira.WorkflowTransitionRule.t()] | nil
        }

  defstruct [:conditionsTree, :postFunctions, :validators]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conditionsTree:
        {:union, [{Jira.WorkflowCompoundCondition, :t}, {Jira.WorkflowSimpleCondition, :t}]},
      postFunctions: [{Jira.WorkflowTransitionRule, :t}],
      validators: [{Jira.WorkflowTransitionRule, :t}]
    ]
  end
end
