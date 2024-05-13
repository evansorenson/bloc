defmodule Jira.PermissionGrants do
  @moduledoc """
  Provides struct and type for a PermissionGrants
  """

  @type t :: %__MODULE__{expand: String.t() | nil, permissions: [Jira.PermissionGrant.t()] | nil}

  defstruct [:expand, :permissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [expand: {:string, :generic}, permissions: [{Jira.PermissionGrant, :t}]]
  end
end
