defmodule Jira.Filter do
  @moduledoc """
  Provides struct and type for a Filter
  """

  @type t :: %__MODULE__{
          approximateLastUsed: DateTime.t() | nil,
          description: String.t() | nil,
          editPermissions: [Jira.SharePermission.t()] | nil,
          favourite: boolean | nil,
          favouritedCount: integer | nil,
          id: String.t() | nil,
          jql: String.t() | nil,
          name: String.t(),
          owner: Jira.FilterOwner.t() | nil,
          searchUrl: String.t() | nil,
          self: String.t() | nil,
          sharePermissions: [Jira.SharePermission.t()] | nil,
          sharedUsers: Jira.FilterSharedUsers.t() | nil,
          subscriptions: Jira.FilterSubscriptions.t() | nil,
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
      editPermissions: [{Jira.SharePermission, :t}],
      favourite: :boolean,
      favouritedCount: :integer,
      id: {:string, :generic},
      jql: {:string, :generic},
      name: {:string, :generic},
      owner: {Jira.FilterOwner, :t},
      searchUrl: {:string, :uri},
      self: {:string, :uri},
      sharePermissions: [{Jira.SharePermission, :t}],
      sharedUsers: {Jira.FilterSharedUsers, :t},
      subscriptions: {Jira.FilterSubscriptions, :t},
      viewUrl: {:string, :uri}
    ]
  end
end
