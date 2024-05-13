defmodule Jira.ProjectComponentAssignee do
  @moduledoc """
  Provides struct and type for a ProjectComponentAssignee
  """

  @type t :: %__MODULE__{
          accountId: String.t() | nil,
          accountType: String.t() | nil,
          active: boolean | nil,
          applicationRoles: map | nil,
          avatarUrls: map | nil,
          displayName: String.t() | nil,
          emailAddress: String.t() | nil,
          expand: String.t() | nil,
          groups: map | nil,
          key: String.t() | nil,
          locale: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil,
          timeZone: String.t() | nil
        }

  defstruct [
    :accountId,
    :accountType,
    :active,
    :applicationRoles,
    :avatarUrls,
    :displayName,
    :emailAddress,
    :expand,
    :groups,
    :key,
    :locale,
    :name,
    :self,
    :timeZone
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accountId: {:string, :generic},
      accountType: {:enum, ["atlassian", "app", "customer", "unknown"]},
      active: :boolean,
      applicationRoles: :map,
      avatarUrls: :map,
      displayName: {:string, :generic},
      emailAddress: {:string, :generic},
      expand: {:string, :generic},
      groups: :map,
      key: {:string, :generic},
      locale: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :uri},
      timeZone: {:string, :generic}
    ]
  end
end
