defmodule Jirex.WorkflowElementReference do
  @moduledoc """
  Provides struct and type for a WorkflowElementReference
  """

  @type t :: %__MODULE__{
          propertyKey: String.t() | nil,
          ruleId: String.t() | nil,
          statusMappingReference: Jirex.ProjectAndIssueTypePair.t() | nil,
          statusReference: String.t() | nil,
          transitionId: String.t() | nil
        }

  defstruct [:propertyKey, :ruleId, :statusMappingReference, :statusReference, :transitionId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      propertyKey: {:string, :generic},
      ruleId: {:string, :generic},
      statusMappingReference: {Jirex.ProjectAndIssueTypePair, :t},
      statusReference: {:string, :generic},
      transitionId: {:string, :generic}
    ]
  end
end
