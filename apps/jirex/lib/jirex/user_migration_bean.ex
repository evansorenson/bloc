defmodule Jirex.UserMigrationBean do
  @moduledoc """
  Provides struct and type for a UserMigrationBean
  """

  @type t :: %__MODULE__{
          accountId: String.t() | nil,
          key: String.t() | nil,
          username: String.t() | nil
        }

  defstruct [:accountId, :key, :username]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [accountId: {:string, :generic}, key: {:string, :generic}, username: {:string, :generic}]
  end
end
