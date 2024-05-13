defmodule Jira.CreateWorkflowTransitionRule do
  @moduledoc """
  Provides struct and type for a CreateWorkflowTransitionRule
  """

  @type t :: %__MODULE__{
          configuration: Jira.CreateWorkflowTransitionRuleConfiguration.t() | nil,
          type: String.t()
        }

  defstruct [:configuration, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      configuration: {Jira.CreateWorkflowTransitionRuleConfiguration, :t},
      type: {:string, :generic}
    ]
  end
end
