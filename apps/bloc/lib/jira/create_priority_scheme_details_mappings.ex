defmodule Jira.CreatePrioritySchemeDetailsMappings do
  @moduledoc """
  Provides struct and type for a CreatePrioritySchemeDetailsMappings
  """

  @type t :: %__MODULE__{in: map | nil, out: map | nil}

  defstruct [:in, :out]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [in: :map, out: :map]
  end
end
