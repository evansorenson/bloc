defmodule Jirex.BulkProjectPermissions do
  @moduledoc """
  Provides struct and type for a BulkProjectPermissions
  """

  @type t :: %__MODULE__{
          issues: [integer] | nil,
          permissions: [String.t()],
          projects: [integer] | nil
        }

  defstruct [:issues, :permissions, :projects]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issues: [:integer], permissions: [string: :generic], projects: [:integer]]
  end
end
