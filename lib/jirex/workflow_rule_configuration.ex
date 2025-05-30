defmodule Jirex.WorkflowRuleConfiguration do
  @moduledoc """
  Provides struct and type for a WorkflowRuleConfiguration
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          parameters: Jirex.WorkflowRuleConfigurationParameters.t() | nil,
          ruleKey: String.t()
        }

  defstruct [:id, :parameters, :ruleKey]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      parameters: {Jirex.WorkflowRuleConfigurationParameters, :t},
      ruleKey: {:string, :generic}
    ]
  end
end
