defmodule Rolex.Role do
  @moduledoc """
  Representation of a role
  """
  alias Rolex.Check

  @type t :: %__MODULE__{
          name: atom(),
          checks: [[Check.t()]]
        }

  defstruct [:name, checks: []]

  @doc false
  def push_checks(%__MODULE__{} = role, new_checks) when length(new_checks) > 1 do
    if length(new_checks) > length(Enum.uniq(new_checks)) do
      raise "Duplicate checks"
    else
      run_push_checks(role, new_checks)
    end
  end

  def push_checks(%__MODULE__{checks: _checks} = role, new_checks) do
    run_push_checks(role, new_checks)
  end

  @doc false
  defp run_push_checks(%__MODULE__{checks: checks} = role, new_checks) do
    new_checks =
      Enum.flat_map(new_checks, fn
        %Check{} = check ->
          if Enum.member?(checks, [check]) do
            raise "Duplicate check \"#{inspect(check.call)}\" defined for role \"#{role.name}\"."
          else
            [check]
          end

        {role_name, _check} when role_name != role.name ->
          []

        {_, check} ->
          [check]
      end)

    # Flat Mapping a single value

    # Flat Mapping a tuple where the second item is a list and doesn't match expected

    # Fallback
    check_list = Enum.filter([new_checks | checks], fn check_list -> length(check_list) > 0 end)

    %__MODULE__{role | checks: check_list}
  end

  @doc """
  Applies all checks defined in the role returning if all the checks returned a `true`.

  The checks are defined as a 2d list where each inner list is evaluated as a boolean `OR` expression
  and combined with every other inner list as a boolean `AND` expression

  e.g.
  NOTE: The following Checks have been evaluated to their boolean representation

  ```
  [
    [true, false, true],
    [true],
    [false]
  ]
  ```

  `(true || false || true) && (true) && (false) == false`

  """
  @spec apply_checks(t(), Rolex.user(), Rolex.scope(), Rolex.permission(), Rolex.object()) ::
          boolean()
  def apply_checks(%__MODULE__{checks: checks} = _role, user, scope, permission, object) do
    Enum.all?(
      checks,
      &Enum.any?(&1, fn check -> Check.apply(check, user, scope, permission, object) end)
    )
  end

  @doc """
  Applies all the checks defined in the roles, but only returns the objects that pass
  all of the checks.
  """
  @spec filter(t(), Rolex.user(), Rolex.scope(), Rolex.permission(), [Rolex.object()]) :: [
          Rolex.object()
        ]
  def filter(%__MODULE__{checks: []} = _role, _user, _scope, _permission, objects), do: objects

  def filter(%__MODULE__{checks: checks} = _role, user, scope, permission, objects) do
    checks
    |> Enum.map(fn check_arr ->
      Enum.flat_map(check_arr, &Check.filter(&1, user, scope, permission, objects))
    end)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce({0, MapSet.new()}, fn
      ms, {0, _} -> {1, ms}
      ms, {n, acc_ms} -> {n + 1, MapSet.intersection(ms, acc_ms)}
    end)
    |> elem(1)
    |> MapSet.to_list()
  end
end
