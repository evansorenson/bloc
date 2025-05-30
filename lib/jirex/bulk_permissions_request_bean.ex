defmodule Jirex.BulkPermissionsRequestBean do
  @moduledoc """
  Provides struct and type for a BulkPermissionsRequestBean
  """

  @type t :: %__MODULE__{
          accountId: String.t() | nil,
          globalPermissions: [String.t()] | nil,
          projectPermissions: [Jirex.BulkProjectPermissions.t()] | nil
        }

  defstruct [:accountId, :globalPermissions, :projectPermissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accountId: {:string, :generic},
      globalPermissions: [string: :generic],
      projectPermissions: [{Jirex.BulkProjectPermissions, :t}]
    ]
  end
end
