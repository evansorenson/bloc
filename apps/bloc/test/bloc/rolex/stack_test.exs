defmodule Rolex.StackTest do
  use ExUnit.Case, async: true

  # Suppress the warnings generated here as they are actually used
  alias Rolex.Check, warn: false
  alias Rolex.Permission, warn: false
  alias Rolex.Role, warn: false
  alias Rolex.Scope, warn: false
  alias Rolex.Stack, warn: false

  doctest Rolex.Stack

  describe "push/2" do
    test "raises on invalid check location" do
      assert_raise RuntimeError, ~r/invalid check location/, fn ->
        defmodule InvalidCheckLocation do
          @moduledoc false
          Stack.init(__MODULE__)
          Stack.push(__MODULE__, [%Check{}])
        end
      end
    end

    test "raises on invalid permission location" do
      assert_raise RuntimeError, ~r/invalid permission location/, fn ->
        defmodule InvalidPermissionLocation do
          @moduledoc false
          Stack.init(__MODULE__)
          Stack.push(__MODULE__, %Permission{name: :perm_1})
        end
      end
    end

    test "raises on invalid role location" do
      assert_raise RuntimeError, ~r/invalid role location/, fn ->
        defmodule InvalidRoleLocation do
          @moduledoc false
          Stack.init(__MODULE__)
          Stack.push(__MODULE__, %Role{name: :role_1})
        end
      end
    end

    test "raises on invalid scope location" do
      assert_raise RuntimeError, ~r/invalid scope location/, fn ->
        defmodule InvalidScopeLocation do
          @moduledoc false
          Stack.init(__MODULE__)
          Stack.push(__MODULE__, %Scope{name: :scope_1})
          Stack.push(__MODULE__, %Scope{name: :scope_2})
        end
      end
    end
  end
end
