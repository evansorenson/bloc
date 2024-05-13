defmodule Jira.NotificationRestrict do
  @moduledoc """
  Provides struct and type for a NotificationRestrict
  """

  @type t :: %__MODULE__{
          groupIds: [String.t()] | nil,
          groups: [Jira.GroupName.t()] | nil,
          permissions: [Jira.RestrictedPermission.t()] | nil
        }

  defstruct [:groupIds, :groups, :permissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      groupIds: [string: :generic],
      groups: [{Jira.GroupName, :t}],
      permissions: [{Jira.RestrictedPermission, :t}]
    ]
  end
end
