defmodule Jirex.BulkProjectPermissionGrants do
  @moduledoc """
  Provides struct and type for a BulkProjectPermissionGrants
  """

  @type t :: %__MODULE__{issues: [integer], permission: String.t(), projects: [integer]}

  defstruct [:issues, :permission, :projects]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issues: [:integer], permission: {:string, :generic}, projects: [:integer]]
  end
end
