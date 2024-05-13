defmodule Jira.BulkEditShareableEntityRequest do
  @moduledoc """
  Provides struct and type for a BulkEditShareableEntityRequest
  """

  @type t :: %__MODULE__{
          action: String.t(),
          changeOwnerDetails: Jira.BulkEditShareableEntityRequestChangeOwnerDetails.t() | nil,
          entityIds: [integer],
          extendAdminPermissions: boolean | nil,
          permissionDetails: Jira.BulkEditShareableEntityRequestPermissionDetails.t() | nil
        }

  defstruct [
    :action,
    :changeOwnerDetails,
    :entityIds,
    :extendAdminPermissions,
    :permissionDetails
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      action: {:enum, ["changeOwner", "changePermission", "addPermission", "removePermission"]},
      changeOwnerDetails: {Jira.BulkEditShareableEntityRequestChangeOwnerDetails, :t},
      entityIds: [:integer],
      extendAdminPermissions: :boolean,
      permissionDetails: {Jira.BulkEditShareableEntityRequestPermissionDetails, :t}
    ]
  end
end
