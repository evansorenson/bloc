defmodule BlocWeb.TaskLiveTest do
  use BlocWeb.ConnCase

  import Phoenix.LiveViewTest

  @create_attrs %{
    title: "some title",
    notes: "some notes",
    date: "2024-03-29",
    complete?: "2024-03-29T16:31:00",
    active?: "2024-03-29T16:31:00"
  }
  @update_attrs %{
    title: "some updated title",
    notes: "some updated notes",
    due_date: "2024-03-30",
    complete?: "2024-03-30T16:31:00",
    active?: "2024-03-30T16:31:00"
  }
  @invalid_attrs %{
    title: nil,
    notes: nil,
    due_date: nil,
    complete?: nil,
    active?: nil
  }
  setup [:log_in_user, :task]

  describe "Index" do
    test "lists all tasks", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/tasks")

      assert html =~ "Listing Habit periods"
    end

    test "saves new task", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tasks")

      assert index_live |> element("a", "New Habit period") |> render_click() =~
               "New Habit period"

      assert_patch(index_live, ~p"/tasks/new")

      assert index_live
             |> form("#task-form", task: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#task-form", task: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tasks")

      html = render(index_live)
      assert html =~ "Task created successfully"
    end

    test "updates task in listing", %{conn: conn, task: task} do
      {:ok, index_live, _html} = live(conn, ~p"/tasks")

      assert index_live
             |> element("#tasks-#{task.id} a", "Edit")
             |> render_click() =~
               "Edit Task"

      assert_patch(index_live, ~p"/tasks/#{task}/edit")

      assert index_live
             |> form("#task-form", task: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#task-form", task: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tasks")

      html = render(index_live)
      assert html =~ "Task updated successfully"
    end

    test "deletes task in listing", %{conn: conn, task: task} do
      {:ok, index_live, _html} = live(conn, ~p"/tasks")

      assert index_live
             |> element("#tasks-#{task.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#tasks-#{task.id}")
    end
  end

  describe "Show" do
    test "displays task", %{conn: conn, task: task} do
      {:ok, _show_live, html} = live(conn, ~p"/tasks/#{task}")

      assert html =~ "Show Habit period"
    end

    test "updates task within modal", %{conn: conn, task: task} do
      {:ok, show_live, _html} = live(conn, ~p"/tasks/#{task}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Habit period"

      assert_patch(show_live, ~p"/tasks/#{task}/show/edit")

      assert show_live
             |> form("#task-form", task: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#task-form", task: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/tasks/#{task}")

      html = render(show_live)
      assert html =~ "Habit period updated successfully"
    end
  end
end
