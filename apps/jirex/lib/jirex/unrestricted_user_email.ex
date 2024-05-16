defmodule Jirex.UnrestrictedUserEmail do
  @moduledoc """
  Provides struct and type for a UnrestrictedUserEmail
  """

  @type t :: %__MODULE__{accountId: String.t() | nil, email: String.t() | nil}

  defstruct [:accountId, :email]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [accountId: {:string, :generic}, email: {:string, :generic}]
  end
end
