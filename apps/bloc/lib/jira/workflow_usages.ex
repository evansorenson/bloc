defmodule Jira.WorkflowUsages do
  @moduledoc """
  Provides struct and type for a WorkflowUsages
  """

  @type t :: %__MODULE__{workflowId: String.t() | nil, workflowName: String.t() | nil}

  defstruct [:workflowId, :workflowName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [workflowId: {:string, :generic}, workflowName: {:string, :generic}]
  end
end
