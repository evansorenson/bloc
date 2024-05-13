defmodule Jira.PermissionsKeysBean do
  @moduledoc """
  Provides struct and type for a PermissionsKeysBean
  """

  @type t :: %__MODULE__{permissions: [String.t()]}

  defstruct [:permissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [permissions: [string: :generic]]
  end
end
