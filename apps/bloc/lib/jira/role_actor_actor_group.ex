defmodule Jira.RoleActorActorGroup do
  @moduledoc """
  Provides struct and type for a RoleActorActorGroup
  """

  @type t :: %__MODULE__{
          displayName: String.t() | nil,
          groupId: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:displayName, :groupId, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [displayName: {:string, :generic}, groupId: {:string, :generic}, name: {:string, :generic}]
  end
end
