defmodule Jira.WorkflowSchemeReadRequest do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeReadRequest
  """

  @type t :: %__MODULE__{projectIds: [String.t()] | nil, workflowSchemeIds: [String.t()] | nil}

  defstruct [:projectIds, :workflowSchemeIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [projectIds: [string: :generic], workflowSchemeIds: [string: :generic]]
  end
end
