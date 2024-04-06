defmodule Bloc.Utils.Ok do
  @doc """
  Wraps the item in a tuple with `:ok` atom.

  ## Examples

      iex> Bloc.Utils.Ok.wrap("hello")
      {:ok, "hello"}
  """
  @spec wrap(item :: any()) :: {:ok, any()}
  def wrap(item), do: {:ok, item}
end
