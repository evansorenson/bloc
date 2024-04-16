defmodule Bloc.Blocks do
  @moduledoc """
  The Blocks context.
  """

  import Ecto.Query, warn: false
  alias Bloc.Scope
  alias Bloc.Repo

  alias Bloc.Blocks.Block

  @doc """
  Returns the list of blocks.

  ## Examples

      iex> list_blocks(%Scope{})
      [%Block{}, ...]

  """
  def list_blocks(%Scope{} = scope, opts \\ []) do
    all_query(Block, scope, opts)
  end

  defp all_query(query, %Scope{current_user_id: user_id}, opts) do
    query
    |> QueryBuilder.where(user_id: user_id)
    # |> QueryBuilder.preload([:task])
    |> QueryBuilder.from_list(opts)
    |> Repo.all()
  end

  def blocks_for_day(%Scope{timezone: timezone} = scope, opts \\ []) do
    beginning_of_day =
      timezone |> Timex.now() |> Timex.beginning_of_day() |> Timex.Timezone.convert("UTC")

    end_of_day = timezone |> Timex.now() |> Timex.end_of_day() |> Timex.Timezone.convert("UTC")

    Block
    |> QueryBuilder.where({:start_time, :ge, beginning_of_day})
    |> QueryBuilder.where({:start_time, :le, end_of_day})
    |> all_query(scope, opts)
  end

  @doc """
  Gets first available time for day's time blocks.
  """
  def first_available_time(blocks, opts \\ [timezone: "America/Chicago"])

  def first_available_time([], _opts) do
    DateTime.utc_now()
  end

  def first_available_time(blocks, _opts) do
    blocks
    |> Enum.reduce_while(hd(blocks).start_time, fn block, last_end_time ->
      if last_end_time == block.start_time do
        {:cont, block.end_time}
      else
        {:halt, last_end_time}
      end
    end)
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
