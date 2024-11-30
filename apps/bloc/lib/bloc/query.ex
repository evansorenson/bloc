defmodule Bloc.Query do
  @moduledoc false
  import Ecto.Query

  alias Bloc.Scope

  def for_scope(query, %Scope{} = scope) do
    where(query, [q], q.user_id == ^scope.current_user_id)
  end

  def for_user(query, user_id) do
    where(query, [q], q.user_id == ^user_id)
  end

  def preloads(query, nil), do: query

  def preloads(query, preloads) when is_list(preloads) do
    preload(query, ^preloads)
  end

  def order_by_position(query) do
    order_by(query, [q], asc: q.position)
  end
end
