defmodule Jira.EntityPropertyDetails do
  @moduledoc """
  Provides struct and type for a EntityPropertyDetails
  """

  @type t :: %__MODULE__{entityId: number, key: String.t(), value: String.t()}

  defstruct [:entityId, :key, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [entityId: :number, key: {:string, :generic}, value: {:string, :generic}]
  end
end
