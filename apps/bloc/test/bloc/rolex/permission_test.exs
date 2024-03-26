defmodule Rolex.PermissionTest do
  use ExUnit.Case, async: true

  doctest Rolex.Permission

  alias Rolex.Check
  alias Rolex.Permission
  alias Rolex.Role

  @falsey_role %Role{name: :falsey, checks: [[%Check{call: {__MODULE__, :false_check}}]]}
  @truthy_role %Role{name: :truthy, checks: [[%Check{call: {__MODULE__, :true_check}}]]}
  @empty_role %Role{name: :empty, checks: []}

  @filter_falsey_role %Role{
    name: :falsey,
    checks: [[%Check{call: {__MODULE__, :filter_false_check}}]]
  }
  @filter_truthy_role %Role{
    name: :truthy,
    checks: [[%Check{call: {__MODULE__, :filter_true_check}}]]
  }
  @filter_both_role %Role{name: :both, checks: [[%Check{call: {__MODULE__, :filter_both_check}}]]}

  def false_check(_scope, _permission, _user, _object), do: false
  def true_check(_scope, _permission, _user, _object), do: true

  def filter_false_check(_scope, _permission, _user, _objects), do: []
  def filter_true_check(_scope, _permission, _user, objects), do: objects

  def filter_both_check(_scope, _permission, _user, objects) do
    Enum.filter(objects, fn
      "foo" -> true
      "bar" -> false
    end)
  end

  describe "add_role/2" do
    test "adds role by name" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @falsey_role)

      assert %Permission{
               name: :test_perm,
               roles: %{
                 falsey: %Role{
                   name: :falsey,
                   checks: [[%Check{call: {__MODULE__, :false_check}}]]
                 }
               }
             } == perm
    end

    test "raises when duplicate role is added" do
      assert_raise RuntimeError, ~r/^Duplicate role/, fn ->
        %Permission{name: :test_perm}
        |> Permission.add_role(@falsey_role)
        |> Permission.add_role(@falsey_role)
      end
    end
  end

  describe "can?/4" do
    test "returns false if the role checks return false" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @falsey_role)

      refute Permission.can?(perm, %{roles: [:falsey]}, :scope, %{})
    end

    test "returns false if the role 'or' checks return false" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @falsey_role)

      refute Permission.can?(perm, %{roles: [:falsey]}, :scope, %{})
    end

    test "returns true if there are no role checks or check anys" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @empty_role)

      assert Permission.can?(perm, %{roles: [:empty]}, :scope, %{})
    end

    test "returns true for role check any on matching roles" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @truthy_role)

      assert Permission.can?(perm, %{roles: [:truthy]}, :scope, %{})
    end

    test "only runs role checks for matching roles" do
      perm =
        %Permission{name: :test_perm}
        |> Permission.add_role(@falsey_role)
        |> Permission.add_role(@truthy_role)

      assert Permission.can?(perm, %{roles: [:truthy]}, :scope, %{})
      refute Permission.can?(perm, %{roles: [:falsey]}, :scope, %{})
    end

    test "only runs role check any for matching roles" do
      perm =
        %Permission{name: :test_perm}
        |> Permission.add_role(@falsey_role)
        |> Permission.add_role(@truthy_role)

      assert Permission.can?(perm, %{roles: [:truthy]}, :scope, %{})
      refute Permission.can?(perm, %{roles: [:falsey]}, :scope, %{})
    end

    test "returns true if any of the roles return true" do
      perm =
        %Permission{name: :test_perm}
        |> Permission.add_role(@falsey_role)
        |> Permission.add_role(@truthy_role)

      assert Permission.can?(perm, %{roles: [:truthy, :falsey]}, :scope, %{})
      # assert ordering does not matter
      assert Permission.can?(perm, %{roles: [:falsey, :truthy]}, :scope, %{})
    end

    test "uses the custom :roles_getter if provided" do
      perm =
        %Permission{name: :test_perm, roles_getter: fn _ -> [:truthy] end}
        |> Permission.add_role(@truthy_role)

      assert Permission.can?(perm, %{}, :scope, %{})
    end
  end

  describe "filter/4" do
    test "returns on false side if role check return false" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @filter_falsey_role)

      assert Permission.filter(perm, %{roles: [:falsey]}, :scope, [%{}]) == []
    end

    test "returns on false side if the role check return true" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @filter_truthy_role)

      assert Permission.filter(perm, %{roles: [:truthy]}, :scope, [%{}]) == [%{}]
    end

    test "returns on true side if there are no role checks or check anys" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @empty_role)

      assert Permission.filter(perm, %{roles: [:empty]}, :scope, [%{}]) == [%{}]
    end

    test "returns both sides if there are multiple objects" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @filter_both_role)

      assert Permission.filter(perm, %{roles: [:both]}, :scope, ["foo", "bar"]) == ["foo"]
    end

    test "only runs role checks for matching roles" do
      perm =
        %Permission{name: :test_perm}
        |> Permission.add_role(@filter_falsey_role)
        |> Permission.add_role(@filter_truthy_role)

      assert Permission.filter(perm, %{roles: [:truthy]}, :scope, ["foo"]) == ["foo"]
      assert Permission.filter(perm, %{roles: [:falsey]}, :scope, ["foo"]) == []
    end

    test "returns true if any of the roles return true" do
      perm =
        %Permission{name: :test_perm}
        |> Permission.add_role(@filter_falsey_role)
        |> Permission.add_role(@filter_truthy_role)

      assert Permission.filter(perm, %{roles: [:truthy, :falsey]}, :scope, ["foo"]) == ["foo"]
      assert Permission.filter(perm, %{roles: [:falsey, :truthy]}, :scope, ["foo"]) == ["foo"]
    end

    test "uses the custom :roles_getter if provided" do
      perm =
        %Permission{name: :test_perm, roles_getter: fn _ -> [:truthy] end}
        |> Permission.add_role(@filter_truthy_role)

      assert ["foo"] = Permission.filter(perm, %{}, :scope, ["foo"])
    end
  end

  describe "has?/2" do
    test "returns true if the user has the role even with falsey check" do
      perm = %Permission{name: :test_perm}
      perm = Permission.add_role(perm, @falsey_role)

      assert Permission.has?(perm, %{roles: [:falsey]})
    end

    test "returns false if the user does not have any of the roles" do
      perm =
        %Permission{name: :test_perm}
        |> Permission.add_role(@falsey_role)
        |> Permission.add_role(@truthy_role)
        |> Permission.add_role(@empty_role)

      refute Permission.has?(perm, %{roles: [:nada]})
    end

    test "returns false if the user has no roles" do
      perm =
        %Permission{name: :test_perm}
        |> Permission.add_role(@falsey_role)
        |> Permission.add_role(@truthy_role)
        |> Permission.add_role(@empty_role)

      refute Permission.has?(perm, %{roles: []})
    end

    test "uses the custom :roles_getter if provided" do
      perm =
        %Permission{name: :test_perm, roles_getter: fn _ -> [:truthy] end}
        |> Permission.add_role(@truthy_role)

      assert Permission.has?(perm, %{})
    end
  end
end
