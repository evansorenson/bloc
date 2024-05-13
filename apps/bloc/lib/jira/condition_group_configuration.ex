defmodule Jira.ConditionGroupConfiguration do
  @moduledoc """
  Provides struct and type for a ConditionGroupConfiguration
  """

  @type t :: %__MODULE__{
          conditionGroups: [Jira.ConditionGroupConfiguration.t()] | nil,
          conditions: [Jira.WorkflowRuleConfiguration.t()] | nil,
          operation: String.t() | nil
        }

  defstruct [:conditionGroups, :conditions, :operation]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conditionGroups: [{Jira.ConditionGroupConfiguration, :t}],
      conditions: [{Jira.WorkflowRuleConfiguration, :t}],
      operation: {:enum, ["ANY", "ALL"]}
    ]
  end
end
