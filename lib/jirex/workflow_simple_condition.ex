defmodule Jirex.WorkflowSimpleCondition do
  @moduledoc """
  Provides struct and type for a WorkflowSimpleCondition
  """

  @type t :: %__MODULE__{configuration: map | nil, nodeType: String.t(), type: String.t()}

  defstruct [:configuration, :nodeType, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [configuration: :map, nodeType: {:string, :generic}, type: {:string, :generic}]
  end
end
