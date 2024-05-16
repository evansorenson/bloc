defmodule Jirex.ConditionGroupUpdate do
  @moduledoc """
  Provides struct and type for a ConditionGroupUpdate
  """

  @type t :: %__MODULE__{
          conditionGroups: [Jirex.ConditionGroupUpdate.t()] | nil,
          conditions: [Jirex.WorkflowRuleConfiguration.t()] | nil,
          operation: String.t()
        }

  defstruct [:conditionGroups, :conditions, :operation]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conditionGroups: [{Jirex.ConditionGroupUpdate, :t}],
      conditions: [{Jirex.WorkflowRuleConfiguration, :t}],
      operation: {:enum, ["ANY", "ALL"]}
    ]
  end
end
