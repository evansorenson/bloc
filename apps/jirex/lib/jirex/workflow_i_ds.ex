defmodule Jirex.WorkflowIDs do
  @moduledoc """
  Provides struct and type for a WorkflowIDs
  """

  @type t :: %__MODULE__{entityId: String.t() | nil, name: String.t()}

  defstruct [:entityId, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [entityId: {:string, :generic}, name: {:string, :generic}]
  end
end
