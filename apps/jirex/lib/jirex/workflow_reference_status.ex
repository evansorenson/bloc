defmodule Jirex.WorkflowReferenceStatus do
  @moduledoc """
  Provides struct and type for a WorkflowReferenceStatus
  """

  @type t :: %__MODULE__{
          deprecated: boolean | nil,
          layout: Jirex.WorkflowStatusLayout.t() | nil,
          properties: Jirex.WorkflowReferenceStatusProperties.t() | nil,
          statusReference: String.t() | nil
        }

  defstruct [:deprecated, :layout, :properties, :statusReference]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      deprecated: :boolean,
      layout: {Jirex.WorkflowStatusLayout, :t},
      properties: {Jirex.WorkflowReferenceStatusProperties, :t},
      statusReference: {:string, :generic}
    ]
  end
end
