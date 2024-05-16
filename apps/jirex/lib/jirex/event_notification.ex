defmodule Jirex.EventNotification do
  @moduledoc """
  Provides struct and type for a EventNotification
  """

  @type t :: %__MODULE__{
          emailAddress: String.t() | nil,
          expand: String.t() | nil,
          field: Jirex.EventNotificationField.t() | nil,
          group: Jirex.EventNotificationGroup.t() | nil,
          id: integer | nil,
          notificationType: String.t() | nil,
          parameter: String.t() | nil,
          projectRole: Jirex.EventNotificationProjectRole.t() | nil,
          recipient: String.t() | nil,
          user: Jirex.EventNotificationUser.t() | nil
        }

  defstruct [
    :emailAddress,
    :expand,
    :field,
    :group,
    :id,
    :notificationType,
    :parameter,
    :projectRole,
    :recipient,
    :user
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      emailAddress: {:string, :generic},
      expand: {:string, :generic},
      field: {Jirex.EventNotificationField, :t},
      group: {Jirex.EventNotificationGroup, :t},
      id: :integer,
      notificationType:
        {:enum,
         [
           "CurrentAssignee",
           "Reporter",
           "CurrentUser",
           "ProjectLead",
           "ComponentLead",
           "User",
           "Group",
           "ProjectRole",
           "EmailAddress",
           "AllWatchers",
           "UserCustomField",
           "GroupCustomField"
         ]},
      parameter: {:string, :generic},
      projectRole: {Jirex.EventNotificationProjectRole, :t},
      recipient: {:string, :generic},
      user: {Jirex.EventNotificationUser, :t}
    ]
  end
end
