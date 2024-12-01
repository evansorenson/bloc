defmodule Jirex.CreateWorkflowStatusDetails do
  @moduledoc """
  Provides struct and type for a CreateWorkflowStatusDetails
  """

  @type t :: %__MODULE__{
          id: String.t(),
          properties: Jirex.CreateWorkflowStatusDetailsProperties.t() | nil
        }

  defstruct [:id, :properties]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: {:string, :generic}, properties: {Jirex.CreateWorkflowStatusDetailsProperties, :t}]
  end
end
