defmodule Jira.PermissionScheme do
  @moduledoc """
  Provides struct and type for a PermissionScheme
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          expand: String.t() | nil,
          id: integer | nil,
          name: String.t(),
          permissions: [Jira.PermissionGrant.t()] | nil,
          scope: Jira.PermissionSchemeScope.t() | nil,
          self: String.t() | nil
        }

  defstruct [:description, :expand, :id, :name, :permissions, :scope, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      expand: {:string, :generic},
      id: :integer,
      name: {:string, :generic},
      permissions: [{Jira.PermissionGrant, :t}],
      scope: {Jira.PermissionSchemeScope, :t},
      self: {:string, :uri}
    ]
  end
end
