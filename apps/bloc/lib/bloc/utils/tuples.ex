defmodule Tuples do
  @moduledoc false
  @doc """
  Wraps the item in a tuple with `:ok` atom.

  ## Examples

      iex> Tuples.ok("hello")
      {:ok, "hello"}
  """
  @spec ok(item :: any()) :: {:ok, any()}
  def ok(item), do: {:ok, item}

  @doc """
  Wraps the item in a tuple with `:error` atom.

  ## Examples

      iex> Tuples.error("hello")
      {:error, "hello"}
  """
  @spec error(item :: any()) :: {:error, any()}
  def error(item), do: {:error, item}

  @doc """
  Wraps the item in a tuple with `:noreply` atom.

  ## Examples

      iex> Tuples.noreply("hello")
      {:noreply, "hello"}
  """
  @spec noreply(item :: any()) :: {:noreply, any()}
  def noreply(item), do: {:noreply, item}
end
