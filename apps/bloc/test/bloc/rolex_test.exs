defmodule RolexTest do
  use ExUnit.Case, async: true, capture_io: true

  doctest Rolex

  describe "scope/1" do
    test "raises on nested scopes" do
      assert_raise RuntimeError, ~r/^invalid scope location/, fn ->
        defmodule NestedScopes do
          @moduledoc false
          use Rolex

          scope :test do
            scope :bad do
            end
          end
        end
      end
    end

    test "raises on duplicate scopes" do
      assert_raise RuntimeError, ~r/^scope ":test" is duplicated.$/, fn ->
        defmodule DuplicateScopes do
          @moduledoc false
          use Rolex

          scope :test do
          end

          scope :test do
          end
        end
      end
    end
  end

  describe "role/1" do
    test "raises on unknown role" do
      assert_raise RuntimeError, ~r/^unknown role/, fn ->
        defmodule UnknownRole do
          @moduledoc false
          use Rolex

          scope :role_test do
            permission :will_fail do
              role(:bad_role)
            end
          end
        end
      end
    end
  end

  describe "checks" do
    test "raises when not implemented for remote checks" do
      assert_raise RuntimeError, ~r/^invalid check {OtherModule, :remote}/, fn ->
        defmodule RemoteChecks do
          @moduledoc false
          use Rolex

          roles([
            :test_role
          ])

          scope :test_scope do
            permission :test_perm do
              role :test_role do
                check(OtherModule, :remote)
              end
            end
          end
        end
      end
    end

    test "raises when not implemented for local checks" do
      assert_raise RuntimeError, ~r/^invalid check {RolexTest.LocalChecks, :local_check}/, fn ->
        defmodule LocalChecks do
          @moduledoc false
          use Rolex

          roles([
            :test_role
          ])

          scope :test_scope do
            permission :test_perm do
              role :test_role do
                check(:local_check)
              end
            end
          end
        end
      end
    end

    test "does not raise on implemented local checks" do
      defmodule GoodLocalChecks do
        @moduledoc false
        use Rolex

        roles([
          :test_role
        ])

        scope :test_scope do
          permission :test_perm do
            role :test_role do
              check(:local_check)
            end
          end
        end

        def local_check(_user, _scope, _permission, _obj), do: false
      end
    end
  end

  describe "checks 'and' and 'or'" do
    defmodule Checker do
      @moduledoc false
      def is_true?(_, _, _, _), do: true
      def is_true_again?(_, _, _, _), do: true
      def is_false?(_, _, _, _), do: false
      def is_false_again?(_, _, _, _), do: false
    end

    defmodule CheckAny do
      @moduledoc false
      use Rolex

      roles([:test_role])

      scope :test_scope do
        permission :empty_or do
          role :test_role do
            check([])
          end
        end

        permission :pass_or do
          role :test_role do
            check([
              {Checker, :is_true?},
              {Checker, :is_false?}
            ])
          end
        end

        permission :fail_or do
          role :test_role do
            check([
              {Checker, :is_false?},
              {Checker, :is_false_again?}
            ])
          end
        end

        permission :pass_or_pass_and do
          role :test_role do
            check([
              {Checker, :is_false?},
              {Checker, :is_true?}
            ])

            check(Checker, :is_true_again?)
          end
        end

        permission :pass_or_fail_and do
          role :test_role do
            check([
              {Checker, :is_false?},
              {Checker, :is_true?}
            ])

            check(Checker, :is_false_again?)
          end
        end

        permission :fail_or_pass_and do
          role :test_role do
            check([
              {Checker, :is_false?},
              {Checker, :is_false_again?}
            ])

            check(Checker, :is_true?)
          end
        end

        permission :fail_or_fail_and do
          role :test_role do
            check([
              {Checker, :is_false?},
              {Checker, :is_false_again?}
            ])

            check(:is_false_local?)
          end
        end
      end

      def is_false_local?(_, _, _, _), do: false
    end

    test "returns true if there are no 'or' checks" do
      assert CheckAny.can?(%{roles: [:test_role]}, :test_scope, :empty_or, nil)
    end

    test "returns true if any 'or' check passes" do
      assert CheckAny.can?(%{roles: [:test_role]}, :test_scope, :pass_or, nil)
    end

    test "returns false if no 'or' check passes" do
      refute CheckAny.can?(%{roles: [:test_role]}, :test_scope, :fail_or, nil)
    end

    test "returns true if 'or' checks pass and 'and' checks pass" do
      assert CheckAny.can?(%{roles: [:test_role]}, :test_scope, :pass_or_pass_and, nil)
    end

    test "returns false if 'or' checks pass and 'and' checks fail" do
      refute CheckAny.can?(%{roles: [:test_role]}, :test_scope, :pass_or_fail_and, nil)
    end

    test "returns false if 'or' checks fail and 'and' checks fail" do
      refute CheckAny.can?(%{roles: [:test_role]}, :test_scope, :fail_or_fail_and, nil)
    end
  end

  describe "can?/4" do
    defmodule TestUserCan do
      @moduledoc false
      use Rolex

      roles([:test_role])

      scope :test_scope do
        permission :test_perm do
          role(:test_role)
        end
      end
    end

    test "raises on unknown scope" do
      assert_raise RuntimeError, ~r/unknown scope/, fn ->
        TestUserCan.can?(%{}, :unknown, :view, %{})
      end
    end

    test "raises on unknown permission" do
      assert_raise RuntimeError, ~r/unknown permission/, fn ->
        TestUserCan.can?(%{}, :test_scope, :unknown, %{})
      end
    end
  end

  describe "filter/4" do
    defmodule TestFilter do
      @moduledoc false
      use Rolex

      roles([:role_a, :role_b])

      check(:role_a, TestFilter, :is_true)

      scope :test_scope do
        permission :test_perm do
          role :role_a do
            check(:one_of_each)
          end

          role :role_b do
            check([
              {TestFilter, :is_true_objects},
              {TestFilter, :is_false_objects}
            ])
          end
        end
      end

      def is_true(_, _, _, _), do: true

      def is_true_objects(_, _, _, objects), do: objects

      def is_false_objects(_, _, _, _), do: []

      def one_of_each(_, _, _, objects) do
        Enum.filter(objects, fn
          "foo" -> true
          "bar" -> false
        end)
      end
    end

    test "Correctly filters by the roles and checks" do
      assert TestFilter.filter(%{roles: [:role_a, :role_b]}, :test_scope, :test_perm, [
               "foo",
               "bar"
             ]) == ["foo", "bar"]

      assert TestFilter.filter(%{roles: [:role_a]}, :test_scope, :test_perm, ["foo"]) == ["foo"]
      assert TestFilter.filter(%{roles: [:role_a]}, :test_scope, :test_perm, ["bar"]) == []
    end
  end

  describe "split/4" do
    defmodule TestSplit do
      @moduledoc false
      use Rolex

      roles([:role_a, :role_b])

      check(:role_a, TestSplit, :is_true)

      scope :test_scope do
        permission :test_perm do
          role :role_a do
            check(:one_of_each)
          end

          role :role_b do
            check([
              {TestSplit, :is_true_objects},
              {TestSplit, :is_false_objects}
            ])
          end
        end
      end

      def is_true(_, _, _, _), do: true

      def is_true_objects(_, _, _, objects), do: objects

      def is_false_objects(_, _, _, _), do: []

      def one_of_each(_, _, _, objects) do
        Enum.filter(objects, fn
          "foo" -> true
          "bar" -> false
        end)
      end
    end

    test "Correctly splits by the roles and checks" do
      assert TestSplit.split(%{roles: [:role_a, :role_b]}, :test_scope, :test_perm, ["foo", "bar"]) ==
               {["foo", "bar"], []}

      assert TestSplit.split(%{roles: [:role_a]}, :test_scope, :test_perm, ["foo"]) ==
               {["foo"], []}

      assert TestSplit.split(%{roles: [:role_a]}, :test_scope, :test_perm, ["bar"]) ==
               {[], ["bar"]}
    end
  end

  describe "has?/4" do
    defmodule TestUserHas do
      @moduledoc false
      use Rolex

      roles([:test_role])

      scope :test_scope do
        permission :test_perm do
          role :test_role do
            check(:always_no)
          end
        end
      end

      def always_no(_user, _scope, _permission, _obj), do: false
    end

    test "raises on unknown scope" do
      assert_raise RuntimeError, ~r/unknown scope/, fn ->
        TestUserHas.has?(%{}, :unknown, :view)
      end
    end

    test "raises on unknown permission" do
      assert_raise RuntimeError, ~r/unknown permission/, fn ->
        TestUserHas.has?(%{}, :test_scope, :unknown)
      end
    end
  end

  describe "additional usages" do
    test "can use module attributes" do
      # A totally overkill example where we can test
      # each macro accepts module attributes
      defmodule CanUseModuleAttributes do
        @moduledoc false
        use Rolex

        @test_role :test_role
        @another_roles [@test_role]

        @test_scope :test_scope
        @test_perm :test_perm
        @attribute_check :attribute_check
        @another_attribute :another_attribute

        roles(@another_roles)

        check(@test_role, @attribute_check)

        scope @test_scope do
          permission @test_perm do
            role @test_role do
              check(@another_attribute)
            end
          end
        end

        def attribute_check(_user, _scope, _permission, _obj), do: false
        def another_attribute(_user, _scope, _permission, _obj), do: false
      end

      scopes = CanUseModuleAttributes.scopes()
      scope = Map.get(scopes, :test_scope)
      refute is_nil(scope)

      perm = Map.get(scope.permissions, :test_perm)
      refute is_nil(perm)
      role = Map.get(perm.roles, :test_role)
      assert 2 == length(role.checks)
    end

    test "can use for loops" do
      defmodule CanUseForLoops do
        @moduledoc false
        use Rolex

        roles([:test_role, :another_test])

        scope :test_scope do
          permission :test_perm do
            for role_name <- [:test_role, :another_test] do
              role role_name do
                check(:always_no)
              end
            end
          end
        end

        def always_no(_user, _scope, _permission, _obj), do: false
      end

      scopes = CanUseForLoops.scopes()

      perm =
        scopes
        |> Map.get(:test_scope)
        |> Map.get(:permissions)
        |> Map.get(:test_perm)

      assert 2 ==
               perm.roles
               |> Map.keys()
               |> length()

      for role_name <- [:test_role, :another_test] do
        role =
          perm
          |> Map.get(:roles)
          |> Map.get(role_name)

        refute is_nil(role)
        assert 1 == length(role.checks)
      end
    end
  end

  describe ":roles_getter option" do
    defmodule CustomRoleGetter do
      @moduledoc false
      use Rolex, roles_getter: &__MODULE__.get_roles/1

      roles([:test_role])

      scope :test_scope do
        permission :test_perm do
          role(:test_role)
        end
      end

      def get_roles(_user), do: [:test_role]
    end

    test "sets the :roles_getter attribute on generated Permission structs" do
      perm =
        CustomRoleGetter.scopes()
        |> Map.get(:test_scope)
        |> Map.get(:permissions)
        |> Map.get(:test_perm)

      assert perm.roles_getter == (&CustomRoleGetter.get_roles/1)
    end
  end
end
