defmodule Jirex.WorkflowStatusUpdate do
  @moduledoc """
  Provides struct and type for a WorkflowStatusUpdate
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          name: String.t(),
          statusCategory: String.t(),
          statusReference: String.t()
        }

  defstruct [:description, :id, :name, :statusCategory, :statusReference]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      statusCategory: {:enum, ["TODO", "IN_PROGRESS", "DONE"]},
      statusReference: {:string, :generic}
    ]
  end
end
