defmodule Jira.CreateWorkflowTransitionDetailsRules do
  @moduledoc """
  Provides struct and type for a CreateWorkflowTransitionDetailsRules
  """

  @type t :: %__MODULE__{
          conditions: Jira.CreateWorkflowTransitionDetailsRulesConditions.t() | nil,
          postFunctions: [Jira.CreateWorkflowTransitionRule.t()] | nil,
          validators: [Jira.CreateWorkflowTransitionRule.t()] | nil
        }

  defstruct [:conditions, :postFunctions, :validators]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conditions: {Jira.CreateWorkflowTransitionDetailsRulesConditions, :t},
      postFunctions: [{Jira.CreateWorkflowTransitionRule, :t}],
      validators: [{Jira.CreateWorkflowTransitionRule, :t}]
    ]
  end
end
