defmodule Jira.WorkflowTransitionProperty do
  @moduledoc """
  Provides struct and type for a WorkflowTransitionProperty
  """

  @type t :: %__MODULE__{id: String.t() | nil, key: String.t() | nil, value: String.t()}

  defstruct [:id, :key, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: {:string, :generic}, key: {:string, :generic}, value: {:string, :generic}]
  end
end
