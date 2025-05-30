defmodule Jirex.MappingsByIssueTypeOverride do
  @moduledoc """
  Provides struct and type for a MappingsByIssueTypeOverride
  """

  @type t :: %__MODULE__{
          issueTypeId: String.t(),
          statusMappings: [Jirex.WorkflowAssociationStatusMapping.t()]
        }

  defstruct [:issueTypeId, :statusMappings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issueTypeId: {:string, :generic},
      statusMappings: [{Jirex.WorkflowAssociationStatusMapping, :t}]
    ]
  end
end
