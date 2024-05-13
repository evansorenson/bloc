defmodule Jira.NotificationTo do
  @moduledoc """
  Provides struct and type for a NotificationTo
  """

  @type t :: %__MODULE__{
          assignee: boolean | nil,
          groupIds: [String.t()] | nil,
          groups: [Jira.GroupName.t()] | nil,
          reporter: boolean | nil,
          users: [Jira.UserDetails.t()] | nil,
          voters: boolean | nil,
          watchers: boolean | nil
        }

  defstruct [:assignee, :groupIds, :groups, :reporter, :users, :voters, :watchers]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      assignee: :boolean,
      groupIds: [string: :generic],
      groups: [{Jira.GroupName, :t}],
      reporter: :boolean,
      users: [{Jira.UserDetails, :t}],
      voters: :boolean,
      watchers: :boolean
    ]
  end
end
