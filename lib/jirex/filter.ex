defmodule Jirex.Filter do
  @moduledoc """
  Provides struct and type for a Filter
  """

  @type t :: %__MODULE__{
          approximateLastUsed: DateTime.t() | nil,
          description: String.t() | nil,
          editPermissions: [Jirex.SharePermission.t()] | nil,
          favourite: boolean | nil,
          favouritedCount: integer | nil,
          id: String.t() | nil,
          jql: String.t() | nil,
          name: String.t(),
          owner: Jirex.FilterOwner.t() | nil,
          searchUrl: String.t() | nil,
          self: String.t() | nil,
          sharePermissions: [Jirex.SharePermission.t()] | nil,
          sharedUsers: Jirex.FilterSharedUsers.t() | nil,
          subscriptions: Jirex.FilterSubscriptions.t() | nil,
          viewUrl: String.t() | nil
        }

  defstruct [
    :approximateLastUsed,
    :description,
    :editPermissions,
    :favourite,
    :favouritedCount,
    :id,
    :jql,
    :name,
    :owner,
    :searchUrl,
    :self,
    :sharePermissions,
    :sharedUsers,
    :subscriptions,
    :viewUrl
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      approximateLastUsed: {:string, :date_time},
      description: {:string, :generic},
      editPermissions: [{Jirex.SharePermission, :t}],
      favourite: :boolean,
      favouritedCount: :integer,
      id: {:string, :generic},
      jql: {:string, :generic},
      name: {:string, :generic},
      owner: {Jirex.FilterOwner, :t},
      searchUrl: {:string, :uri},
      self: {:string, :uri},
      sharePermissions: [{Jirex.SharePermission, :t}],
      sharedUsers: {Jirex.FilterSharedUsers, :t},
      subscriptions: {Jirex.FilterSubscriptions, :t},
      viewUrl: {:string, :uri}
    ]
  end
end
