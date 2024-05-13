defmodule Jira.BulkEditShareableEntityRequestPermissionDetails do
  @moduledoc """
  Provides struct and type for a BulkEditShareableEntityRequestPermissionDetails
  """

  @type t :: %__MODULE__{
          editPermissions: [Jira.SharePermission.t()] | nil,
          sharePermissions: [Jira.SharePermission.t()] | nil
        }

  defstruct [:editPermissions, :sharePermissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      editPermissions: [{Jira.SharePermission, :t}],
      sharePermissions: [{Jira.SharePermission, :t}]
    ]
  end
end
