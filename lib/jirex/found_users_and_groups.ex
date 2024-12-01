defmodule Jirex.FoundUsersAndGroups do
  @moduledoc """
  Provides struct and type for a FoundUsersAndGroups
  """

  @type t :: %__MODULE__{groups: Jirex.FoundGroups.t() | nil, users: Jirex.FoundUsers.t() | nil}

  defstruct [:groups, :users]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [groups: {Jirex.FoundGroups, :t}, users: {Jirex.FoundUsers, :t}]
  end
end
