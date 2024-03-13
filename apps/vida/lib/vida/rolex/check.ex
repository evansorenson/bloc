defmodule Rolex.Check do
  @moduledoc """
  Type used to represent a check.
  """

  @typedoc """
  Stores as `{module, function}`, arity is assumed 4.
  """
  @type call :: {atom(), atom()}

  @type t :: %__MODULE__{
          call: call()
        }

  defstruct [:call]

  require Logger

  @doc """
  Apply the check returning if it was successful.
  """
  @spec apply(t(), Rolex.user(), Rolex.scope(), Rolex.permission(), Rolex.object()) :: boolean()
  def apply(%__MODULE__{call: {mod, fun}}, user, scope, perm, object) do
    apply(mod, fun, [user, scope, perm, object]) == true
  end

  @doc """
  Apply the check and return only the objects that passed the check.
  If the underlying check returns true, it is assumed that the check passed for all of the objects.
  If the underlying check returns false, it is assumed that the check failed for all of the objects.
  If the underlying check returns a list of objects, it is assumed that those objects are the ones that passed the check.
  Otherwise, it is assumed that all of the objects did not pass the check.
  """
  @spec filter(t(), Rolex.user(), Rolex.scope(), Rolex.permission(), [Rolex.object()]) :: [
          Rolex.object()
        ]
  def filter(%__MODULE__{call: {mod, fun}}, user, scope, perm, objects) do
    case apply(mod, fun, [user, scope, perm, objects]) do
      true ->
        objects

      false ->
        []

      objs when is_list(objs) ->
        objs

      _ ->
        Logger.error(
          "ERROR: Rolex check functions must return true, false, or a list of the objects that pass the check."
        )

        []
    end
  end
end
