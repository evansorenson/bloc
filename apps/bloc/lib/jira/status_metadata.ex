defmodule Jira.StatusMetadata do
  @moduledoc """
  Provides struct and type for a StatusMetadata
  """

  @type t :: %__MODULE__{category: String.t() | nil, id: String.t() | nil, name: String.t() | nil}

  defstruct [:category, :id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      category: {:enum, ["TODO", "IN_PROGRESS", "DONE"]},
      id: {:string, :generic},
      name: {:string, :generic}
    ]
  end
end
