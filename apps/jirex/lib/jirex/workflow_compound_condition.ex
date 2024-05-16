defmodule Jirex.WorkflowCompoundCondition do
  @moduledoc """
  Provides struct and type for a WorkflowCompoundCondition
  """

  @type t :: %__MODULE__{
          conditions: [Jirex.WorkflowCompoundCondition.t() | Jirex.WorkflowSimpleCondition.t()],
          nodeType: String.t(),
          operator: String.t()
        }

  defstruct [:conditions, :nodeType, :operator]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      conditions: [
        union: [{Jirex.WorkflowCompoundCondition, :t}, {Jirex.WorkflowSimpleCondition, :t}]
      ],
      nodeType: {:string, :generic},
      operator: {:enum, ["AND", "OR"]}
    ]
  end
end
