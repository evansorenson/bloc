defmodule Rolex.ScopeTest do
  use ExUnit.Case, async: true

  doctest Rolex.Scope

  alias Rolex.Permission
  alias Rolex.Scope

  @perm %Permission{name: :perm}

  describe "add_permission/2" do
    test "adds permission" do
      scope = Scope.add_permission(%Scope{name: :test}, @perm)

      assert Map.has_key?(scope.permissions, :perm)
    end

    test "raises on duplicate permission name" do
      assert_raise RuntimeError, ~r/Duplicate permission/, fn ->
        %Scope{name: :test}
        |> Scope.add_permission(@perm)
        |> Scope.add_permission(@perm)
      end
    end
  end
end
