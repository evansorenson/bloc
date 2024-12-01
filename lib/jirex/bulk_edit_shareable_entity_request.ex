defmodule Jirex.BulkEditShareableEntityRequest do
  @moduledoc """
  Provides struct and type for a BulkEditShareableEntityRequest
  """

  @type t :: %__MODULE__{
          action: String.t(),
          changeOwnerDetails: Jirex.BulkEditShareableEntityRequestChangeOwnerDetails.t() | nil,
          entityIds: [integer],
          extendAdminPermissions: boolean | nil,
          permissionDetails: Jirex.BulkEditShareableEntityRequestPermissionDetails.t() | nil
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
      changeOwnerDetails: {Jirex.BulkEditShareableEntityRequestChangeOwnerDetails, :t},
      entityIds: [:integer],
      extendAdminPermissions: :boolean,
      permissionDetails: {Jirex.BulkEditShareableEntityRequestPermissionDetails, :t}
    ]
  end
end
