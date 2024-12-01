defmodule Jirex.SharePermission do
  @moduledoc """
  Provides struct and type for a SharePermission
  """

  @type t :: %__MODULE__{
          group: Jirex.SharePermissionGroup.t() | nil,
          id: integer | nil,
          project: Jirex.SharePermissionProject.t() | nil,
          role: Jirex.SharePermissionRole.t() | nil,
          type: String.t(),
          user: Jirex.SharePermissionUser.t() | nil
        }

  defstruct [:group, :id, :project, :role, :type, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      group: {Jirex.SharePermissionGroup, :t},
      id: :integer,
      project: {Jirex.SharePermissionProject, :t},
      role: {Jirex.SharePermissionRole, :t},
      type:
        {:enum,
         [
           "user",
           "group",
           "project",
           "projectRole",
           "global",
           "loggedin",
           "authenticated",
           "project-unknown"
         ]},
      user: {Jirex.SharePermissionUser, :t}
    ]
  end
end
