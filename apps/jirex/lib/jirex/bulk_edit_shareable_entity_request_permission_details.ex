defmodule Jirex.BulkEditShareableEntityRequestPermissionDetails do
  @moduledoc """
  Provides struct and type for a BulkEditShareableEntityRequestPermissionDetails
  """

  @type t :: %__MODULE__{
          editPermissions: [Jirex.SharePermission.t()] | nil,
          sharePermissions: [Jirex.SharePermission.t()] | nil
        }

  defstruct [:editPermissions, :sharePermissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      editPermissions: [{Jirex.SharePermission, :t}],
      sharePermissions: [{Jirex.SharePermission, :t}]
    ]
  end
end
