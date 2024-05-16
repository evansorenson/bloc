defmodule Jirex.CreateWorkflowTransitionDetailsRules do
  @moduledoc """
  Provides struct and type for a CreateWorkflowTransitionDetailsRules
  """

  @type t :: %__MODULE__{
          conditions: Jirex.CreateWorkflowTransitionDetailsRulesConditions.t() | nil,
          postFunctions: [Jirex.CreateWorkflowTransitionRule.t()] | nil,
          validators: [Jirex.CreateWorkflowTransitionRule.t()] | nil
        }

  defstruct [:conditions, :postFunctions, :validators]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conditions: {Jirex.CreateWorkflowTransitionDetailsRulesConditions, :t},
      postFunctions: [{Jirex.CreateWorkflowTransitionRule, :t}],
      validators: [{Jirex.CreateWorkflowTransitionRule, :t}]
    ]
  end
end
