defmodule BlocWeb.BlockLiveTest do
  use BlocWeb.ConnCase

  import Phoenix.LiveViewTest

  @create_attrs %{
    title: "some title",
    start_time: "2024-03-25T17:34:00Z",
    end_time: "2024-03-25T17:34:00Z"
  }

  @update_attrs %{
    title: "some updated title",
    start_time: "2024-03-26T17:34:00Z",
    end_time: "2024-03-26T17:34:00Z"
  }
  @invalid_attrs %{title: nil, start_time: nil, end_time: nil}

  setup [:log_in_user, :block]

  describe "Index" do
    test "lists all blocks", %{conn: conn, block: block} do
      {:ok, _index_live, html} = live(conn, ~p"/blocks")

      assert html =~ "Listing Blocks"
      assert html =~ block.title
    end

    test "saves new block", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/blocks")

      assert index_live |> element("a", "New Block") |> render_click() =~
               "New Block"

      assert_patch(index_live, ~p"/blocks/new")

      assert index_live
             |> form("#block-form", block: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#block-form", block: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/blocks")

      html = render(index_live)
      assert html =~ "Block created successfully"
      assert html =~ "some title"
    end

    test "updates block in listing", %{conn: conn, block: block} do
      {:ok, index_live, _html} = live(conn, ~p"/blocks")

      assert index_live |> element("#blocks-#{block.id} a", "Edit") |> render_click() =~
               "Edit Block"

      assert_patch(index_live, ~p"/blocks/#{block}/edit")

      assert index_live
             |> form("#block-form", block: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#block-form", block: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/blocks")

      html = render(index_live)
      assert html =~ "Block updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes block in listing", %{conn: conn, block: block} do
      {:ok, index_live, _html} = live(conn, ~p"/blocks")

      assert index_live |> element("#blocks-#{block.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#blocks-#{block.id}")
    end
  end

  describe "Show" do
    test "displays block", %{conn: conn, block: block} do
      {:ok, _show_live, html} = live(conn, ~p"/blocks/#{block}")

      assert html =~ "Show Block"
      assert html =~ block.title
    end

    test "updates block within modal", %{conn: conn, block: block} do
      {:ok, show_live, _html} = live(conn, ~p"/blocks/#{block}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Block"

      assert_patch(show_live, ~p"/blocks/#{block}/show/edit")

      assert show_live
             |> form("#block-form", block: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#block-form", block: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/blocks/#{block}")

      html = render(show_live)
      assert html =~ "Block updated successfully"
      assert html =~ "some updated title"
    end
  end
end
