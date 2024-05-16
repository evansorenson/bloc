defmodule Jirex.WorkflowRules do
  @moduledoc """
  Provides struct and type for a WorkflowRules
  """

  @type t :: %__MODULE__{
          conditionsTree:
            Jirex.WorkflowCompoundCondition.t() | Jirex.WorkflowSimpleCondition.t() | nil,
          postFunctions: [Jirex.WorkflowTransitionRule.t()] | nil,
          validators: [Jirex.WorkflowTransitionRule.t()] | nil
        }

  defstruct [:conditionsTree, :postFunctions, :validators]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conditionsTree:
        {:union, [{Jirex.WorkflowCompoundCondition, :t}, {Jirex.WorkflowSimpleCondition, :t}]},
      postFunctions: [{Jirex.WorkflowTransitionRule, :t}],
      validators: [{Jirex.WorkflowTransitionRule, :t}]
    ]
  end
end
