defmodule Jira.EntityProperty do
  @moduledoc """
  Provides struct and type for a EntityProperty
  """

  @type t :: %__MODULE__{key: String.t() | nil, value: map | nil}

  defstruct [:key, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [key: {:string, :generic}, value: :map]
  end
end
