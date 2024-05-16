defmodule Jirex.AvailableWorkflowTriggers do
  @moduledoc """
  Provides struct and type for a AvailableWorkflowTriggers
  """

  @type t :: %__MODULE__{
          availableTypes: [Jirex.AvailableWorkflowTriggerTypes.t()],
          ruleKey: String.t()
        }

  defstruct [:availableTypes, :ruleKey]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [availableTypes: [{Jirex.AvailableWorkflowTriggerTypes, :t}], ruleKey: {:string, :generic}]
  end
end
