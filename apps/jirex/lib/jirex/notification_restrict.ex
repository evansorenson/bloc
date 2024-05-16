defmodule Jirex.NotificationRestrict do
  @moduledoc """
  Provides struct and type for a NotificationRestrict
  """

  @type t :: %__MODULE__{
          groupIds: [String.t()] | nil,
          groups: [Jirex.GroupName.t()] | nil,
          permissions: [Jirex.RestrictedPermission.t()] | nil
        }

  defstruct [:groupIds, :groups, :permissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      groupIds: [string: :generic],
      groups: [{Jirex.GroupName, :t}],
      permissions: [{Jirex.RestrictedPermission, :t}]
    ]
  end
end
