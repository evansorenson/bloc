defmodule Jirex.WorkflowSchemeAssociation do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeAssociation
  """

  @type t :: %__MODULE__{issueTypeIds: [String.t()], workflowId: String.t()}

  defstruct [:issueTypeIds, :workflowId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeIds: [string: :generic], workflowId: {:string, :generic}]
  end
end
