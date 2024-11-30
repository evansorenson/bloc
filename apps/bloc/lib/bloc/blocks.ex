defmodule Bloc.Blocks do
  @moduledoc """
  The Blocks context.
  """

  import Ecto.Query, warn: false

  alias Bloc.Blocks.Block
  alias Bloc.Query
  alias Bloc.Repo
  alias Bloc.Scope

  @doc """
  Returns the list of blocks.

  ## Examples

      iex> list_blocks(%Scope{})
      [%Block{}, ...]

  """
  def list_blocks(%Scope{current_user_id: user_id}, opts \\ []) do
    Block
    |> Query.for_user(user_id)
    |> Query.preloads(opts[:preload])
    |> Repo.all()
  end

  def blocks_for_day(%Scope{timezone: timezone} = scope, opts \\ []) do
    beginning_of_day =
      timezone |> DateTime.now!() |> Timex.beginning_of_day() |> Timex.Timezone.convert("UTC")

    end_of_day =
      timezone |> DateTime.now!() |> Timex.end_of_day() |> Timex.Timezone.convert("UTC")

    Block
    |> Query.for_user(scope.current_user_id)
    |> between_times({beginning_of_day, end_of_day})
    |> Query.preloads(opts[:preload])
    |> Repo.all()
  end

  @doc """
  Gets first available time for day's time blocks.
  """
  def first_available_time(blocks, opts \\ [timezone: "America/Chicago"])

  def first_available_time([], _opts) do
    DateTime.utc_now()
  end

  def first_available_time(blocks, _opts) do
    Enum.reduce_while(blocks, hd(blocks).start_time, fn block, last_end_time ->
      if last_end_time == block.start_time do
        {:cont, block.end_time}
      else
        {:halt, last_end_time}
      end
    end)
  end

  defp between_times(query, nil), do: query

  defp between_times(query, {start_time, end_time}) do
    query
    |> where([q], q.start_time >= ^start_time)
    |> where([q], q.start_time <= ^end_time)
  end

  @doc """
  Gets a single block.

  Raises `Ecto.NoResultsError` if the Block does not exist.

  ## Examples

      iex> get_block!(123)
      %Block{}

      iex> get_block!(456)
      ** (Ecto.NoResultsError)

  """
  def get_block!(id), do: Repo.get!(Block, id)

  @doc """
  Creates a block.

  ## Examples

      iex> create_block(%{field: value})
      {:ok, %Block{}}

      iex> create_block(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_block(attrs \\ %{}) do
    %Block{}
    |> Block.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a block.

  ## Examples

      iex> update_block(block, %{field: new_value})
      {:ok, %Block{}}

      iex> update_block(block, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_block(%Block{} = block, attrs) do
    block
    |> Block.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a block.

  ## Examples

      iex> delete_block(block)
      {:ok, %Block{}}

      iex> delete_block(block)
      {:error, %Ecto.Changeset{}}

  """
  def delete_block(%Block{} = block) do
    Repo.delete(block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking block changes.

  ## Examples

      iex> change_block(block)
      %Ecto.Changeset{data: %Block{}}

  """
  def change_block(%Block{} = block, attrs \\ %{}) do
    Block.changeset(block, attrs)
  end
end
