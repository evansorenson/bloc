defmodule BlocWeb.TaskListLiveTest do
  use BlocWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bloc.TasksFixtures

  @create_attrs %{position: 42, title: "some title", color: "some color"}
  @update_attrs %{position: 43, title: "some updated title", color: "some updated color"}
  @invalid_attrs %{position: nil, title: nil, color: nil}

  defp create_task_list(_) do
    task_list = task_list_fixture()
    %{task_list: task_list}
  end

  describe "Index" do
    setup [:create_task_list]

    test "lists all task_lists", %{conn: conn, task_list: task_list} do
      {:ok, _index_live, html} = live(conn, ~p"/task_lists")

      assert html =~ "Listing Task lists"
      assert html =~ task_list.title
    end

    test "saves new task_list", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/task_lists")

      assert index_live |> element("a", "New Task list") |> render_click() =~
               "New Task list"

      assert_patch(index_live, ~p"/task_lists/new")

      assert index_live
             |> form("#task_list-form", task_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#task_list-form", task_list: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/task_lists")

      html = render(index_live)
      assert html =~ "Task list created successfully"
      assert html =~ "some title"
    end

    test "updates task_list in listing", %{conn: conn, task_list: task_list} do
      {:ok, index_live, _html} = live(conn, ~p"/task_lists")

      assert index_live |> element("#task_lists-#{task_list.id} a", "Edit") |> render_click() =~
               "Edit Task list"

      assert_patch(index_live, ~p"/task_lists/#{task_list}/edit")

      assert index_live
             |> form("#task_list-form", task_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#task_list-form", task_list: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/task_lists")

      html = render(index_live)
      assert html =~ "Task list updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes task_list in listing", %{conn: conn, task_list: task_list} do
      {:ok, index_live, _html} = live(conn, ~p"/task_lists")

      assert index_live |> element("#task_lists-#{task_list.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#task_lists-#{task_list.id}")
    end
  end

  describe "Show" do
    setup [:create_task_list]

    test "displays task_list", %{conn: conn, task_list: task_list} do
      {:ok, _show_live, html} = live(conn, ~p"/task_lists/#{task_list}")

      assert html =~ "Show Task list"
      assert html =~ task_list.title
    end

    test "updates task_list within modal", %{conn: conn, task_list: task_list} do
      {:ok, show_live, _html} = live(conn, ~p"/task_lists/#{task_list}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Task list"

      assert_patch(show_live, ~p"/task_lists/#{task_list}/show/edit")

      assert show_live
             |> form("#task_list-form", task_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#task_list-form", task_list: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/task_lists/#{task_list}")

      html = render(show_live)
      assert html =~ "Task list updated successfully"
      assert html =~ "some updated title"
    end
  end
end
