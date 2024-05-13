defmodule Jira.RoleActorActorUser do
  @moduledoc """
  Provides struct and type for a RoleActorActorUser
  """

  @type t :: %__MODULE__{accountId: String.t() | nil}

  defstruct [:accountId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [accountId: {:string, :generic}]
  end
end
