defmodule Rolex.Stack do
  @moduledoc false

  alias Rolex.Check
  alias Rolex.Permission
  alias Rolex.Role
  alias Rolex.Scope

  @stack :stack
  @top :top
  @role_checks :role_checks

  @type pushable :: Scope.t() | Permission.t() | Role.t() | Check.t()

  @doc """
  Initialize the module.

  Creates a few module attributes used throughout the DSL. Particularly stack and top. The stack is used for nesting scopes/roles. Top is used to reference the current scope/role that has been nested.
  """
  @spec init(module()) :: nil
  def init(module) do
    Module.put_attribute(module, @stack, [])
    Module.put_attribute(module, @role_checks, [])
    Module.put_attribute(module, @top, nil)

    nil
  end

  @doc """
  Determine if the stack is currently in the root
  """
  @spec is_root?(module()) :: boolean()
  def is_root?(module) do
    is_nil(get_top(module))
  end

  @doc """
  Pushes a scope onto the module stack.
  """
  @spec push(module(), pushable()) :: nil
  def push(module, item) do
    case item do
      %Scope{} = scope ->
        push_scope(module, scope)

      %Role{} = role ->
        push_role(module, role)

      %Permission{} = perm ->
        push_permission(module, perm)

      checks when is_list(checks) ->
        push_checks(module, checks)
    end

    nil
  end

  @doc """
  Removes a frame from the stack
  """
  @spec pop(module()) :: pushable()
  def pop(module) do
    case get_top(module) do
      %Role{} = role ->
        pop_role(module, role)
        role

      %Permission{} = perm ->
        pop_permission(module, perm)
        perm

      %Scope{} = scope ->
        pop_scope(module, scope)
        scope

      checks when is_list(checks) ->
        pop_checks(module, checks)
        checks
    end
  end

  @doc """
  Stores a role level check. This is a global thing that applies to all scopes.
  """
  @spec role_check(module(), atom(), Check.t()) :: nil
  def role_check(module, role, %Check{} = check) do
    update_attribute(module, @role_checks, fn checks ->
      [{role, check} | checks]
    end)

    nil
  end

  defp push_checks(module, checks) when is_list(checks) do
    case get_top(module) do
      %Role{} = top ->
        update_stack(module, fn stack -> [top | stack] end)
        put_top(module, checks)

      _other ->
        raise "invalid check location -- checks are only allowed inside of a role definition. Attempted to create check \"#{inspect(Enum.map(checks, & &1.call))}\"."
    end
  end

  defp push_permission(module, perm) do
    case get_top(module) do
      %Scope{name: scope} = top when is_atom(scope) ->
        update_stack(module, fn stack -> [top | stack] end)
        put_top(module, perm)

      _other ->
        raise "invalid permission location -- permissions are only allowed within a scope definition. Attempted to create permission \"#{inspect(perm.name)}\""
    end
  end

  defp push_role(module, role) do
    case get_top(module) do
      %Permission{name: perm} = top when is_atom(perm) ->
        update_stack(module, fn stack -> [top | stack] end)
        role_checks = get_attribute(module, @role_checks)
        role = Role.push_checks(role, role_checks)
        put_top(module, role)

      _other ->
        raise "invalid role location -- roles are only allowed inside of a permission definition. Attempted to create role \"#{inspect(role.name)}\""
    end
  end

  defp push_scope(module, scope) do
    case get_top(module) do
      # Ensure we are on the very top stack
      nil ->
        update_stack(module, fn stack -> [nil | stack] end)
        put_top(module, scope)

      _other ->
        raise "invalid scope location -- scopes are only allowed at the root. Attempted to create scope \"#{inspect(scope.name)}\""
    end
  end

  defp pop_role(module, role) do
    update_stack(module, fn [perm | stack] ->
      perm = Permission.add_role(perm, role)
      put_top(module, perm)
      stack
    end)
  end

  defp pop_permission(module, perm) do
    update_stack(module, fn [scope | stack] ->
      scope = Scope.add_permission(scope, perm)
      put_top(module, scope)
      stack
    end)
  end

  defp pop_scope(module, _scope) do
    update_stack(module, fn [nil | stack] ->
      put_top(module, nil)
      stack
    end)
  end

  defp pop_checks(module, checks) do
    update_stack(module, fn [role | stack] ->
      role = Role.push_checks(role, checks)
      put_top(module, role)
      stack
    end)
  end

  defp update_stack(module, fun) do
    update_attribute(module, @stack, fun)
  end

  defp get_top(module) do
    get_attribute(module, @top)
  end

  defp put_top(module, value) do
    Module.put_attribute(module, @top, value)
    value
  end

  defp get_attribute(module, attr) do
    Module.get_attribute(module, attr)
  end

  defp update_attribute(module, attr, fun) do
    Module.put_attribute(module, attr, fun.(get_attribute(module, attr)))
  end
end
