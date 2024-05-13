defmodule Jira.SharePermissionInputBean do
  @moduledoc """
  Provides struct and type for a SharePermissionInputBean
  """

  @type t :: %__MODULE__{
          accountId: String.t() | nil,
          groupId: String.t() | nil,
          groupname: String.t() | nil,
          projectId: String.t() | nil,
          projectRoleId: String.t() | nil,
          rights: integer | nil,
          type: String.t()
        }

  defstruct [:accountId, :groupId, :groupname, :projectId, :projectRoleId, :rights, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accountId: {:string, :generic},
      groupId: {:string, :generic},
      groupname: {:string, :generic},
      projectId: {:string, :generic},
      projectRoleId: {:string, :generic},
      rights: :integer,
      type: {:enum, ["user", "project", "group", "projectRole", "global", "authenticated"]}
    ]
  end
end
