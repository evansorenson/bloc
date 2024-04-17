defmodule Bloc.BlocksTest do
  use Bloc.DataCase

  alias Bloc.Blocks
  alias Bloc.Scope

  setup [:user, :block]

  describe "blocks" do
    alias Bloc.Blocks.Block

    @invalid_attrs %{title: nil, start_time: nil, end_time: nil, user_id: nil}

    test "list_blocks/0 returns all blocks for user", %{user: user, block: block} do
      assert [queried_block] = Blocks.list_blocks(%Scope{current_user_id: user.id})
      assert queried_block.id == block.id
    end

    test "get_block!/1 returns the block with given id", %{block: block} do
      assert Blocks.get_block!(block.id).id == block.id
    end

    test "create_block/1 with valid data creates a block", %{user: user} do
      valid_attrs = %{
        user_id: user.id,
        title: "some title",
        start_time: ~U[2024-03-25 17:33:00Z],
        end_time: ~U[2024-03-25 17:34:00Z]
      }

      assert {:ok, %Block{} = block} = Blocks.create_block(valid_attrs)
      assert block.title == "some title"
      assert block.start_time == ~U[2024-03-25 17:33:00Z]
      assert block.end_time == ~U[2024-03-25 17:34:00Z]
    end

    test "doesn't create block when start time is after end time", %{user: user} do
      invalid_attrs = %{
        user_id: user.id,
        title: "some title",
        start_time: ~U[2024-03-25 17:34:00Z],
        end_time: ~U[2024-03-25 17:33:00Z]
      }

      assert {:error, %Ecto.Changeset{}} = Blocks.create_block(invalid_attrs)
    end

    test "doesn't create block when start time is equal to end time", %{user: user} do
      invalid_attrs = %{
        user_id: user.id,
        title: "some title",
        start_time: ~U[2024-03-25 17:33:00Z],
        end_time: ~U[2024-03-25 17:33:00Z]
      }

      assert {:error, %Ecto.Changeset{}} = Blocks.create_block(invalid_attrs)
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blocks.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block", %{block: block} do
      update_attrs = %{
        title: "some updated title",
        start_time: ~U[2024-03-26 17:33:00Z],
        end_time: ~U[2024-03-26 17:34:00Z]
      }

      assert {:ok, %Block{} = block} = Blocks.update_block(block, update_attrs)
      assert block.title == "some updated title"
      assert block.start_time == ~U[2024-03-26 17:33:00Z]
      assert block.end_time == ~U[2024-03-26 17:34:00Z]
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = insert(:block)
      assert {:error, %Ecto.Changeset{}} = Blocks.update_block(block, @invalid_attrs)
      assert block.updated_at == Blocks.get_block!(block.id).updated_at
    end

    test "delete_block/1 deletes the block" do
      block = insert(:block)
      assert {:ok, %Block{}} = Blocks.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> Blocks.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = insert(:block)
      assert %Ecto.Changeset{} = Blocks.change_block(block)
    end

    # test "blocks_for_day/2 returns all blocks for a given day" do
    #   user = insert(:user)
    #   block = insert(:block, user: user, start_time: ~U[2024-03-25 17:34:00Z])
    #   assert [queried_block] = Blocks.blocks_for_day(user, ~U[2024-03-25 ])
    #   assert queried_block.id == block.id
    # end
  end
end
