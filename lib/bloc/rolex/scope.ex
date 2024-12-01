defmodule Rolex.Scope do
  @moduledoc """
  Representation of a scope
  """
  alias Rolex.Permission

  @type t :: %__MODULE__{
          name: atom(),
          permissions: %{atom() => Permission.t()}
        }

  defstruct [:name, permissions: Map.new()]

  @doc false
  def add_permission(%__MODULE__{permissions: perms} = scope, %Permission{} = perm) do
    if Map.has_key?(perms, perm.name) do
      raise "Duplicate permission \"#{perm.name}\" found in scope \"#{scope.name}\"."
    end

    perms = Map.put(perms, perm.name, perm)
    %__MODULE__{scope | permissions: perms}
  end
end
