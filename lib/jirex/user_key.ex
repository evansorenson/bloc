defmodule Jirex.UserKey do
  @moduledoc """
  Provides struct and type for a UserKey
  """

  @type t :: %__MODULE__{accountId: String.t() | nil, key: String.t() | nil}

  defstruct [:accountId, :key]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [accountId: {:string, :generic}, key: {:string, :generic}]
  end
end
