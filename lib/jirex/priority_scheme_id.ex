defmodule Jirex.PrioritySchemeId do
  @moduledoc """
  Provides struct and type for a PrioritySchemeId
  """

  @type t :: %__MODULE__{id: String.t() | nil, task: Jirex.PrioritySchemeIdTask.t() | nil}

  defstruct [:id, :task]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: {:string, :generic}, task: {Jirex.PrioritySchemeIdTask, :t}]
  end
end
