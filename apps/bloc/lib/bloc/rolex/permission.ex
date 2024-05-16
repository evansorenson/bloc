defmodule Rolex.Permission do
  @moduledoc """
  Representation of a permission.
  """
  alias Rolex.Role

  @type t :: %__MODULE__{
          name: atom(),
          metadata: Keyword.t(),
          roles_getter: Rolex.roles_getter(),
          roles: %{atom() => Role.t()}
        }

  defstruct [:name, :metadata, roles: Map.new(), roles_getter: &__MODULE__.default_roles_getter/1]

  @doc false
  def add_role(%__MODULE__{roles: roles} = perm, %Role{} = role) do
    if Map.has_key?(roles, role.name) do
      raise "Duplicate role \"#{role.name}\" defined for permission \"#{perm.name}\"."
    end

    roles = Map.put(roles, role.name, role)
    %__MODULE__{perm | roles: roles}
  end

  @doc """
  Checks a users roles against the permission for this object. You should not call this directly unless you are overriding `c:Rolex.can?/4`.
  """
  @spec can?(t(), Rolex.user(), Rolex.scope(), Rolex.object()) :: boolean()
  def can?(%__MODULE__{name: name} = permission, user, scope, object) do
    permission
    |> matching_roles(user)
    |> Enum.reduce_while(false, fn role, false ->
      if Role.apply_checks(role, user, scope, name, object) do
        {:halt, true}
      else
        {:cont, false}
      end
    end)
  end

  @doc """
  Checks a users roles against the permission for each of the objects
  and returns only the objects that pass the checks of any of the roles.
  """
  @spec filter(t(), Rolex.user(), Rolex.scope(), [Rolex.object()]) :: [Rolex.object()]
  def filter(%__MODULE__{name: name} = permission, user, scope, objects) do
    permission
    |> matching_roles(user)
    |> Enum.flat_map(fn role -> Role.filter(role, user, scope, name, objects) end)
    |> Enum.uniq()
  end

  @doc """
  Checks a user has a role granted to this permission. You should not call this directly unless you are overriding `c:Rolex.has?/3`.
  """
  @spec has?(t(), Rolex.user()) :: boolean()
  def has?(%__MODULE__{} = permission, user) do
    permission
    |> matching_roles(user)
    |> Enum.any?()
  end

  @doc """
  The default mechanism for getting the `t:Rolex.user/0`'s roles looks up the
  `:roles` key in the user map.  See `t:Rolex.roles_getter/0` for information
  on customizing this value.
  """
  @spec default_roles_getter(Rolex.user()) :: [atom()]
  def default_roles_getter(user), do: Map.get(user, :roles, [])

  defp matching_roles(%__MODULE__{roles: roles, roles_getter: roles_getter}, user) do
    user
    |> roles_getter.()
    |> Enum.flat_map(fn role ->
      case Map.get(roles, role) do
        %Role{} = role -> [role]
        _no_match -> []
      end
    end)
  end
end
