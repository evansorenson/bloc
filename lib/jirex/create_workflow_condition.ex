defmodule Jirex.CreateWorkflowCondition do
  @moduledoc """
  Provides struct and type for a CreateWorkflowCondition
  """

  @type t :: %__MODULE__{
          conditions: [Jirex.CreateWorkflowCondition.t()] | nil,
          configuration: map | nil,
          operator: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [:conditions, :configuration, :operator, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conditions: [{Jirex.CreateWorkflowCondition, :t}],
      configuration: :map,
      operator: {:enum, ["AND", "OR"]},
      type: {:string, :generic}
    ]
  end
end
