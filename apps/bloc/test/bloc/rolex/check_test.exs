defmodule Rolex.CheckTest do
  use ExUnit.Case, async: true

  doctest Rolex.Check

  alias Rolex.Check

  def do_true(scope, perm, user, object) do
    Process.send(self(), {scope, perm, user, object}, [])
    true
  end

  def do_false(_scope, _perm, _user, _object), do: false
  def do_nil(_scope, _perm, _user, _object), do: nil
  def do_other(_scope, _perm, _user, _object), do: :other

  def filter_do_false(_scope, _perm, _user, _objects), do: []
  def filter_do_true(_scope, _perm, _user, objects), do: objects

  def filter_do_both(_scope, _perm, _user, objects) do
    Enum.filter(objects, fn
      "foo" -> true
      "bar" -> false
    end)
  end

  describe "apply/5" do
    test "applies the function and returns true if true" do
      check = %Check{call: {__MODULE__, :do_true}}
      assert Check.apply(check, :scope, :perm, %{user: true}, %{object: true})
      assert_receive {:scope, :perm, %{user: true}, %{object: true}}
    end

    test "coerces nils and other values to false" do
      check = %Check{call: {__MODULE__, :do_false}}
      refute Check.apply(check, :scope, :perm, %{}, %{})

      check = %Check{call: {__MODULE__, :do_nil}}
      refute Check.apply(check, :scope, :perm, %{}, %{})

      check = %Check{call: {__MODULE__, :do_other}}
      refute Check.apply(check, :scope, :perm, %{}, %{})
    end
  end

  describe "filter/5" do
    test "empty objects still work" do
      check = %Check{call: {__MODULE__, :filter_do_true}}
      assert Check.filter(check, :scope, :perm, %{user: true}, []) == []
    end

    test "doesn't returns the objects that fail the checks" do
      check = %Check{call: {__MODULE__, :filter_do_false}}
      assert Check.filter(check, :scope, :perm, %{user: true}, ["foo"]) == []
    end

    test "returns the objects that pass the checks" do
      check = %Check{call: {__MODULE__, :filter_do_true}}
      assert Check.filter(check, :scope, :perm, %{user: true}, ["foo"]) == ["foo"]
    end

    test "only returns objects that pass checks if there are some that pass and some that fail" do
      check = %Check{call: {__MODULE__, :filter_do_both}}
      assert Check.filter(check, :scope, :perm, %{user: true}, ["foo", "bar"]) == ["foo"]
    end

    test "Works with standard checks that return false" do
      check = %Check{call: {__MODULE__, :do_false}}
      assert Check.filter(check, :scope, :perm, %{user: true}, ["foo", "bar"]) == []
    end

    test "Works with standard checks that return true" do
      check = %Check{call: {__MODULE__, :do_true}}
      assert Check.filter(check, :scope, :perm, %{user: true}, ["foo", "bar"]) == ["foo", "bar"]
    end

    test "Returns empty and logs on returning something other than true, false, or a list" do
      check = %Check{call: {__MODULE__, :do_nil}}
      assert Check.filter(check, :scope, :perm, %{user: true}, ["foo"]) == []
    end
  end
end
