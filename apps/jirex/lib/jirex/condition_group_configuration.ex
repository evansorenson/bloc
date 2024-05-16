defmodule Jirex.ConditionGroupConfiguration do
  @moduledoc """
  Provides struct and type for a ConditionGroupConfiguration
  """

  @type t :: %__MODULE__{
          conditionGroups: [Jirex.ConditionGroupConfiguration.t()] | nil,
          conditions: [Jirex.WorkflowRuleConfiguration.t()] | nil,
          operation: String.t() | nil
        }

  defstruct [:conditionGroups, :conditions, :operation]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conditionGroups: [{Jirex.ConditionGroupConfiguration, :t}],
      conditions: [{Jirex.WorkflowRuleConfiguration, :t}],
      operation: {:enum, ["ANY", "ALL"]}
    ]
  end
end
