defmodule Jira.SharePermission do
  @moduledoc """
  Provides struct and type for a SharePermission
  """

  @type t :: %__MODULE__{
          group: Jira.SharePermissionGroup.t() | nil,
          id: integer | nil,
          project: Jira.SharePermissionProject.t() | nil,
          role: Jira.SharePermissionRole.t() | nil,
          type: String.t(),
          user: Jira.SharePermissionUser.t() | nil
        }

  defstruct [:group, :id, :project, :role, :type, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      group: {Jira.SharePermissionGroup, :t},
      id: :integer,
      project: {Jira.SharePermissionProject, :t},
      role: {Jira.SharePermissionRole, :t},
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
      user: {Jira.SharePermissionUser, :t}
    ]
  end
end
