defmodule Jirex.AppWorkflowTransitionRule do
  @moduledoc """
  Provides struct and type for a AppWorkflowTransitionRule
  """

  @type t :: %__MODULE__{
          configuration: Jirex.RuleConfiguration.t(),
          id: String.t(),
          key: String.t(),
          transition: Jirex.AppWorkflowTransitionRuleTransition.t() | nil
        }

  defstruct [:configuration, :id, :key, :transition]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      configuration: {Jirex.RuleConfiguration, :t},
      id: {:string, :generic},
      key: {:string, :generic},
      transition: {Jirex.AppWorkflowTransitionRuleTransition, :t}
    ]
  end
end
