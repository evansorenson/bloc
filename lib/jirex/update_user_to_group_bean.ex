defmodule Jirex.UpdateUserToGroupBean do
  @moduledoc """
  Provides struct and type for a UpdateUserToGroupBean
  """

  @type t :: %__MODULE__{accountId: String.t() | nil, name: String.t() | nil}

  defstruct [:accountId, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [accountId: {:string, :generic}, name: {:string, :generic}]
  end
end
