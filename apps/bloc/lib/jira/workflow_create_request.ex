defmodule Jira.WorkflowCreateRequest do
  @moduledoc """
  Provides struct and type for a WorkflowCreateRequest
  """

  @type t :: %__MODULE__{
          scope: Jira.WorkflowScope.t(),
          statuses: [Jira.WorkflowStatusUpdate.t()],
          workflows: [Jira.WorkflowCreate.t()]
        }

  defstruct [:scope, :statuses, :workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      scope: {Jira.WorkflowScope, :t},
      statuses: [{Jira.WorkflowStatusUpdate, :t}],
      workflows: [{Jira.WorkflowCreate, :t}]
    ]
  end
end
