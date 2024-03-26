defmodule Rolex.RoleTest do
  use ExUnit.Case, async: true

  doctest Rolex.Role

  alias Rolex.Check
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

  describe "push_checks/2" do
    test "pushes new checks" do
      checks = [
        {:empty, %Check{call: {__MODULE__, :fake}}},
        {:empty, %Check{call: {__MODULE__, :super_fake}}}
      ]

      role = Role.push_checks(@empty_role, checks)

      assert 1 == length(role.checks)
      [head | _] = role.checks
      assert 2 == length(head)
      assert elem(List.last(checks), 1) == List.last(head)
      assert elem(List.first(checks), 1) == List.first(head)
    end

    test "raises on duplicate checks" do
      check = %Check{call: {__MODULE__, :fake}}

      assert_raise RuntimeError, ~r/Duplicate check/, fn ->
        @empty_role
        |> Role.push_checks([check])
        |> Role.push_checks([check])
      end
    end

    test "ignores checks for a different role" do
      checks = [
        {:empty, %Check{call: {__MODULE__, :fake}}},
        {:empty, %Check{call: {__MODULE__, :super_fake}}}
      ]

      role = Role.push_checks(@falsey_role, checks)
      assert 1 == length(role.checks)
    end

    test "raises on duplicate check when passing multiple checks" do
      check = %Check{call: {__MODULE__, :fake}}
      check_2 = %Check{call: {__MODULE__, :super_fake}}

      assert_raise RuntimeError, ~r/Duplicate check/, fn ->
        @empty_role
        |> Role.push_checks([check_2])
        |> Role.push_checks([check, check])
      end
    end

    test "raises on duplicate check when single checks" do
      check = %Check{call: {__MODULE__, :fake}}

      assert_raise RuntimeError, ~r/Duplicate check/, fn ->
        @empty_role
        |> Role.push_checks([check])
        |> Role.push_checks([check])
      end
    end
  end

  describe "apply_checks/5" do
    test "returns false if any of the checks return false" do
      refute Role.apply_checks(@falsey_role, :scope, :perm, %{}, %{})

      # Push a falsey check and ensure it fails the role despite having a truthy check as well
      check = %Check{call: {__MODULE__, :false_check}}
      role = Role.push_checks(@truthy_role, [check])

      refute Role.apply_checks(role, %{}, :scope, :perm, %{})
    end

    test "returns true if all the checks return true" do
      assert Role.apply_checks(@truthy_role, %{}, :scope, :perm, %{})
    end

    test "returns true if there are no checks" do
      assert Role.apply_checks(@empty_role, %{}, :scope, :perm, %{})
    end
  end

  describe "filter/5" do
    test "returns an empty list if the check returns false" do
      assert Role.filter(@filter_falsey_role, %{}, :scope, :perm, [%{}]) == []
    end

    test "returns a list containing the objects if the check returns true" do
      assert Role.filter(@filter_truthy_role, %{}, :scope, :perm, [%{}]) == [%{}]
    end

    test "returns a list containing the objects if there are no checks" do
      assert Role.filter(@empty_role, %{}, :scope, :perm, [%{}]) == [%{}]
    end

    test "returns a list containing only the objects that passed the check, if there are multiple objects" do
      assert Role.filter(@filter_both_role, %{}, :scope, :perm, ["foo", "bar"]) == ["foo"]
    end

    test "handles duplicates" do
      assert Role.filter(@filter_both_role, %{}, :scope, :perm, ["foo", "bar", "foo"]) == ["foo"]
    end
  end
end
