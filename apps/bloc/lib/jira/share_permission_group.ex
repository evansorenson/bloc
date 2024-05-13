defmodule Jira.SharePermissionGroup do
  @moduledoc """
  Provides struct and type for a SharePermissionGroup
  """

  @type t :: %__MODULE__{
          groupId: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:groupId, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [groupId: {:string, :generic}, name: {:string, :generic}, self: {:string, :uri}]
  end
end
