defmodule Jira.FoundUsersAndGroups do
  @moduledoc """
  Provides struct and type for a FoundUsersAndGroups
  """

  @type t :: %__MODULE__{groups: Jira.FoundGroups.t() | nil, users: Jira.FoundUsers.t() | nil}

  defstruct [:groups, :users]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [groups: {Jira.FoundGroups, :t}, users: {Jira.FoundUsers, :t}]
  end
end
