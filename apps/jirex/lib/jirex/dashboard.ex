defmodule Jirex.Dashboard do
  @moduledoc """
  Provides struct and type for a Dashboard
  """

  @type t :: %__MODULE__{
          automaticRefreshMs: integer | nil,
          description: String.t() | nil,
          editPermissions: [Jirex.SharePermission.t()] | nil,
          id: String.t() | nil,
          isFavourite: boolean | nil,
          isWritable: boolean | nil,
          name: String.t() | nil,
          owner: Jirex.DashboardOwner.t() | nil,
          popularity: integer | nil,
          rank: integer | nil,
          self: String.t() | nil,
          sharePermissions: [Jirex.SharePermission.t()] | nil,
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
      editPermissions: [{Jirex.SharePermission, :t}],
      id: {:string, :generic},
      isFavourite: :boolean,
      isWritable: :boolean,
      name: {:string, :generic},
      owner: {Jirex.DashboardOwner, :t},
      popularity: :integer,
      rank: :integer,
      self: {:string, :uri},
      sharePermissions: [{Jirex.SharePermission, :t}],
      systemDashboard: :boolean,
      view: {:string, :generic}
    ]
  end
end
