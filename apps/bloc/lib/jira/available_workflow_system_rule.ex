defmodule Jira.AvailableWorkflowSystemRule do
  @moduledoc """
  Provides struct and type for a AvailableWorkflowSystemRule
  """

  @type t :: %__MODULE__{
          description: String.t(),
          incompatibleRuleKeys: [String.t()],
          isAvailableForInitialTransition: boolean,
          isVisible: boolean,
          name: String.t(),
          ruleKey: String.t(),
          ruleType: String.t()
        }

  defstruct [
    :description,
    :incompatibleRuleKeys,
    :isAvailableForInitialTransition,
    :isVisible,
    :name,
    :ruleKey,
    :ruleType
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      incompatibleRuleKeys: [string: :generic],
      isAvailableForInitialTransition: :boolean,
      isVisible: :boolean,
      name: {:string, :generic},
      ruleKey: {:string, :generic},
      ruleType: {:enum, ["Condition", "Validator", "Function", "Screen"]}
    ]
  end
end
