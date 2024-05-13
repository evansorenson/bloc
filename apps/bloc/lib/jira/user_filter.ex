defmodule Jira.UserFilter do
  @moduledoc """
  Provides struct and type for a UserFilter
  """

  @type t :: %__MODULE__{enabled: boolean, groups: [String.t()] | nil, roleIds: [integer] | nil}

  defstruct [:enabled, :groups, :roleIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [enabled: :boolean, groups: [string: :generic], roleIds: [:integer]]
  end
end
