defmodule Jira.WorkflowReferenceStatus do
  @moduledoc """
  Provides struct and type for a WorkflowReferenceStatus
  """

  @type t :: %__MODULE__{
          deprecated: boolean | nil,
          layout: Jira.WorkflowStatusLayout.t() | nil,
          properties: Jira.WorkflowReferenceStatusProperties.t() | nil,
          statusReference: String.t() | nil
        }

  defstruct [:deprecated, :layout, :properties, :statusReference]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      deprecated: :boolean,
      layout: {Jira.WorkflowStatusLayout, :t},
      properties: {Jira.WorkflowReferenceStatusProperties, :t},
      statusReference: {:string, :generic}
    ]
  end
end
