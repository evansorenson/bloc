defmodule Jira.StatusLayoutUpdate do
  @moduledoc """
  Provides struct and type for a StatusLayoutUpdate
  """

  @type t :: %__MODULE__{
          layout: Jira.WorkflowLayout.t() | nil,
          properties: Jira.StatusLayoutUpdateProperties.t(),
          statusReference: String.t()
        }

  defstruct [:layout, :properties, :statusReference]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      layout: {Jira.WorkflowLayout, :t},
      properties: {Jira.StatusLayoutUpdateProperties, :t},
      statusReference: {:string, :generic}
    ]
  end
end
