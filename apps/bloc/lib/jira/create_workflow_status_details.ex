defmodule Jira.CreateWorkflowStatusDetails do
  @moduledoc """
  Provides struct and type for a CreateWorkflowStatusDetails
  """

  @type t :: %__MODULE__{
          id: String.t(),
          properties: Jira.CreateWorkflowStatusDetailsProperties.t() | nil
        }

  defstruct [:id, :properties]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: {:string, :generic}, properties: {Jira.CreateWorkflowStatusDetailsProperties, :t}]
  end
end
