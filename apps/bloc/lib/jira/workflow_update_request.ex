defmodule Jira.WorkflowUpdateRequest do
  @moduledoc """
  Provides struct and type for a WorkflowUpdateRequest
  """

  @type t :: %__MODULE__{
          statuses: [Jira.WorkflowStatusUpdate.t()],
          workflows: [Jira.WorkflowUpdate.t()]
        }

  defstruct [:statuses, :workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [statuses: [{Jira.WorkflowStatusUpdate, :t}], workflows: [{Jira.WorkflowUpdate, :t}]]
  end
end
