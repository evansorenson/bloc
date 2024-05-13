defmodule Jira.RequiredMappingByWorkflows do
  @moduledoc """
  Provides struct and type for a RequiredMappingByWorkflows
  """

  @type t :: %__MODULE__{
          sourceWorkflowId: String.t() | nil,
          statusIds: [String.t()] | nil,
          targetWorkflowId: String.t() | nil
        }

  defstruct [:sourceWorkflowId, :statusIds, :targetWorkflowId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      sourceWorkflowId: {:string, :generic},
      statusIds: [string: :generic],
      targetWorkflowId: {:string, :generic}
    ]
  end
end
