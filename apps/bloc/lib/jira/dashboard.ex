defmodule Jira.Dashboard do
  @moduledoc """
  Provides struct and type for a Dashboard
  """

  @type t :: %__MODULE__{
          automaticRefreshMs: integer | nil,
          description: String.t() | nil,
          editPermissions: [Jira.SharePermission.t()] | nil,
          id: String.t() | nil,
          isFavourite: boolean | nil,
          isWritable: boolean | nil,
          name: String.t() | nil,
          owner: Jira.DashboardOwner.t() | nil,
          popularity: integer | nil,
          rank: integer | nil,
          self: String.t() | nil,
          sharePermissions: [Jira.SharePermission.t()] | nil,
          systemDashboard: boolean | nil,
          view: String.t() | nil
        }

  defstruct [
    :automaticRefreshMs,
    :description,
    :editPermissions,
    :id,
    :isFavourite,
    :isWritable,
    :name,
    :owner,
    :popularity,
    :rank,
    :self,
    :sharePermissions,
    :systemDashboard,
    :view
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      automaticRefreshMs: :integer,
      description: {:string, :generic},
      editPermissions: [{Jira.SharePermission, :t}],
      id: {:string, :generic},
      isFavourite: :boolean,
      isWritable: :boolean,
      name: {:string, :generic},
      owner: {Jira.DashboardOwner, :t},
      popularity: :integer,
      rank: :integer,
      self: {:string, :uri},
      sharePermissions: [{Jira.SharePermission, :t}],
      systemDashboard: :boolean,
      view: {:string, :generic}
    ]
  end
end
