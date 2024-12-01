defmodule Jirex.AvailableWorkflowTriggerTypes do
  @moduledoc """
  Provides struct and type for a AvailableWorkflowTriggerTypes
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          name: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [:description, :name, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: {:string, :generic}, name: {:string, :generic}, type: {:string, :generic}]
  end
end
