defmodule Jirex.StatusLayoutUpdate do
  @moduledoc """
  Provides struct and type for a StatusLayoutUpdate
  """

  @type t :: %__MODULE__{
          layout: Jirex.WorkflowLayout.t() | nil,
          properties: Jirex.StatusLayoutUpdateProperties.t(),
          statusReference: String.t()
        }

  defstruct [:layout, :properties, :statusReference]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      layout: {Jirex.WorkflowLayout, :t},
      properties: {Jirex.StatusLayoutUpdateProperties, :t},
      statusReference: {:string, :generic}
    ]
  end
end
