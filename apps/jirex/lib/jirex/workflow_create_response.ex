defmodule Jirex.WorkflowCreateResponse do
  @moduledoc """
  Provides struct and type for a WorkflowCreateResponse
  """

  @type t :: %__MODULE__{
          statuses: [Jirex.JiraWorkflowStatus.t()] | nil,
          workflows: [Jirex.JiraWorkflow.t()] | nil
        }

  defstruct [:statuses, :workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [statuses: [{Jirex.JiraWorkflowStatus, :t}], workflows: [{Jirex.JiraWorkflow, :t}]]
  end
end
