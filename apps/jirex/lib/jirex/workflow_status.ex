defmodule Jirex.WorkflowStatus do
  @moduledoc """
  Provides struct and type for a WorkflowStatus
  """

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          properties: Jirex.WorkflowStatusProperties.t() | nil
        }

  defstruct [:id, :name, :properties]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      name: {:string, :generic},
      properties: {Jirex.WorkflowStatusProperties, :t}
    ]
  end
end
