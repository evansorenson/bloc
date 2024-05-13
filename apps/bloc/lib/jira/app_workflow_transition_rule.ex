defmodule Jira.AppWorkflowTransitionRule do
  @moduledoc """
  Provides struct and type for a AppWorkflowTransitionRule
  """

  @type t :: %__MODULE__{
          configuration: Jira.RuleConfiguration.t(),
          id: String.t(),
          key: String.t(),
          transition: Jira.AppWorkflowTransitionRuleTransition.t() | nil
        }

  defstruct [:configuration, :id, :key, :transition]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      configuration: {Jira.RuleConfiguration, :t},
      id: {:string, :generic},
      key: {:string, :generic},
      transition: {Jira.AppWorkflowTransitionRuleTransition, :t}
    ]
  end
end
