defmodule Jirex.FilterDetails do
  @moduledoc """
  Provides struct and type for a FilterDetails
  """

  @type t :: %__MODULE__{
          approximateLastUsed: DateTime.t() | nil,
          description: String.t() | nil,
          editPermissions: [Jirex.SharePermission.t()] | nil,
          expand: String.t() | nil,
          favourite: boolean | nil,
          favouritedCount: integer | nil,
          id: String.t() | nil,
          jql: String.t() | nil,
          name: String.t(),
          owner: Jirex.FilterDetailsOwner.t() | nil,
          searchUrl: String.t() | nil,
          self: String.t() | nil,
          sharePermissions: [Jirex.SharePermission.t()] | nil,
          subscriptions: [Jirex.FilterSubscription.t()] | nil,
          viewUrl: String.t() | nil
        }

  defstruct [
    :approximateLastUsed,
    :description,
    :editPermissions,
    :expand,
    :favourite,
    :favouritedCount,
    :id,
    :jql,
    :name,
    :owner,
    :searchUrl,
    :self,
    :sharePermissions,
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
      expand: {:string, :generic},
      favourite: :boolean,
      favouritedCount: :integer,
      id: {:string, :generic},
      jql: {:string, :generic},
      name: {:string, :generic},
      owner: {Jirex.FilterDetailsOwner, :t},
      searchUrl: {:string, :uri},
      self: {:string, :uri},
      sharePermissions: [{Jirex.SharePermission, :t}],
      subscriptions: [{Jirex.FilterSubscription, :t}],
      viewUrl: {:string, :uri}
    ]
  end
end
