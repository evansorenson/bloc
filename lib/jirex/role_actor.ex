defmodule Jirex.RoleActor do
  @moduledoc """
  Provides struct and type for a RoleActor
  """

  @type t :: %__MODULE__{
          actorGroup: Jirex.RoleActorActorGroup.t() | nil,
          actorUser: Jirex.RoleActorActorUser.t() | nil,
          avatarUrl: String.t() | nil,
          displayName: String.t() | nil,
          id: integer | nil,
          name: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [:actorGroup, :actorUser, :avatarUrl, :displayName, :id, :name, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actorGroup: {Jirex.RoleActorActorGroup, :t},
      actorUser: {Jirex.RoleActorActorUser, :t},
      avatarUrl: {:string, :uri},
      displayName: {:string, :generic},
      id: :integer,
      name: {:string, :generic},
      type: {:enum, ["atlassian-group-role-actor", "atlassian-user-role-actor"]}
    ]
  end
end
