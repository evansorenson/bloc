defmodule Jira.MappingsByWorkflow do
  @moduledoc """
  Provides struct and type for a MappingsByWorkflow
  """

  @type t :: %__MODULE__{
          newWorkflowId: String.t(),
          oldWorkflowId: String.t(),
          statusMappings: [Jira.WorkflowAssociationStatusMapping.t()]
        }

  defstruct [:newWorkflowId, :oldWorkflowId, :statusMappings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      newWorkflowId: {:string, :generic},
      oldWorkflowId: {:string, :generic},
      statusMappings: [{Jira.WorkflowAssociationStatusMapping, :t}]
    ]
  end
end
