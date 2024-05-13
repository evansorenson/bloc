defmodule Jira.DashboardOwner do
  @moduledoc """
  Provides struct and type for a DashboardOwner
  """

  @type t :: %__MODULE__{
          accountId: String.t() | nil,
          active: boolean | nil,
          avatarUrls: map | nil,
          displayName: String.t() | nil,
          key: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:accountId, :active, :avatarUrls, :displayName, :key, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accountId: {:string, :generic},
      active: :boolean,
      avatarUrls: :map,
      displayName: {:string, :generic},
      key: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :uri}
    ]
  end
end
