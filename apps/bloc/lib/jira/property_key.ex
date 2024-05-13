defmodule Jira.PropertyKey do
  @moduledoc """
  Provides struct and type for a PropertyKey
  """

  @type t :: %__MODULE__{key: String.t() | nil, self: String.t() | nil}

  defstruct [:key, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [key: {:string, :generic}, self: {:string, :generic}]
  end
end
