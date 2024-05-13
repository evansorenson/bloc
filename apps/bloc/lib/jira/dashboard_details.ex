defmodule Jira.DashboardDetails do
  @moduledoc """
  Provides struct and type for a DashboardDetails
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          editPermissions: [Jira.SharePermission.t()],
          name: String.t(),
          sharePermissions: [Jira.SharePermission.t()]
        }

  defstruct [:description, :editPermissions, :name, :sharePermissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      editPermissions: [{Jira.SharePermission, :t}],
      name: {:string, :generic},
      sharePermissions: [{Jira.SharePermission, :t}]
    ]
  end
end
