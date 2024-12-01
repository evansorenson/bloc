defmodule Jirex.AvailableWorkflowForgeRule do
  @moduledoc """
  Provides struct and type for a AvailableWorkflowForgeRule
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          ruleKey: String.t() | nil,
          ruleType: String.t() | nil
        }

  defstruct [:description, :id, :name, :ruleKey, :ruleType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      ruleKey: {:string, :generic},
      ruleType: {:enum, ["Condition", "Validator", "Function", "Screen"]}
    ]
  end
end
