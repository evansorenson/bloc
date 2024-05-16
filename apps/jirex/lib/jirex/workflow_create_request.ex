defmodule Jirex.WorkflowCreateRequest do
  @moduledoc """
  Provides struct and type for a WorkflowCreateRequest
  """

  @type t :: %__MODULE__{
          scope: Jirex.WorkflowScope.t(),
          statuses: [Jirex.WorkflowStatusUpdate.t()],
          workflows: [Jirex.WorkflowCreate.t()]
        }

  defstruct [:scope, :statuses, :workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      scope: {Jirex.WorkflowScope, :t},
      statuses: [{Jirex.WorkflowStatusUpdate, :t}],
      workflows: [{Jirex.WorkflowCreate, :t}]
    ]
  end
end
