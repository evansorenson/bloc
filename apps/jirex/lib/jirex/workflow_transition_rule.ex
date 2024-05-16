defmodule Jirex.WorkflowTransitionRule do
  @moduledoc """
  Provides struct and type for a WorkflowTransitionRule
  """

  @type t :: %__MODULE__{configuration: map | nil, type: String.t()}

  defstruct [:configuration, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [configuration: :map, type: {:string, :generic}]
  end
end
