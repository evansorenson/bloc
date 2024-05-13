defmodule Jira.RestrictedPermission do
  @moduledoc """
  Provides struct and type for a RestrictedPermission
  """

  @type t :: %__MODULE__{id: String.t() | nil, key: String.t() | nil}

  defstruct [:id, :key]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: {:string, :generic}, key: {:string, :generic}]
  end
end
