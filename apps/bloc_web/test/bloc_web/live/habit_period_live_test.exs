defmodule BlocWeb.HabitPeriodLiveTest do
  use BlocWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bloc.HabitsFixtures

  @create_attrs %{
    unit: :count,
    value: 42,
    date: "2024-03-29",
    period_type: :daily,
    goal: 42,
    complete?: "2024-03-29T16:31:00",
    active?: "2024-03-29T16:31:00"
  }
  @update_attrs %{
    unit: :hr,
    value: 43,
    date: "2024-03-30",
    period_type: :weekly,
    goal: 43,
    complete?: "2024-03-30T16:31:00",
    active?: "2024-03-30T16:31:00"
  }
  @invalid_attrs %{
    unit: nil,
    value: nil,
    date: nil,
    period_type: nil,
    goal: nil,
    complete?: nil,
    active?: nil
  }

  defp create_habit_period(_) do
    habit_period = habit_period_fixture()
    %{habit_period: habit_period}
  end

  describe "Index" do
    setup [:create_habit_period]

    test "lists all habit_periods", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/habit_periods")

      assert html =~ "Listing Habit periods"
    end

    test "saves new habit_period", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/habit_periods")

      assert index_live |> element("a", "New Habit period") |> render_click() =~
               "New Habit period"

      assert_patch(index_live, ~p"/habit_periods/new")

      assert index_live
             |> form("#habit_period-form", habit_period: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#habit_period-form", habit_period: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/habit_periods")

      html = render(index_live)
      assert html =~ "Habit period created successfully"
    end

    test "updates habit_period in listing", %{conn: conn, habit_period: habit_period} do
      {:ok, index_live, _html} = live(conn, ~p"/habit_periods")

      assert index_live
             |> element("#habit_periods-#{habit_period.id} a", "Edit")
             |> render_click() =~
               "Edit Habit period"

      assert_patch(index_live, ~p"/habit_periods/#{habit_period}/edit")

      assert index_live
             |> form("#habit_period-form", habit_period: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#habit_period-form", habit_period: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/habit_periods")

      html = render(index_live)
      assert html =~ "Habit period updated successfully"
    end

    test "deletes habit_period in listing", %{conn: conn, habit_period: habit_period} do
      {:ok, index_live, _html} = live(conn, ~p"/habit_periods")

      assert index_live
             |> element("#habit_periods-#{habit_period.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#habit_periods-#{habit_period.id}")
    end
  end

  describe "Show" do
    setup [:create_habit_period]

    test "displays habit_period", %{conn: conn, habit_period: habit_period} do
      {:ok, _show_live, html} = live(conn, ~p"/habit_periods/#{habit_period}")

      assert html =~ "Show Habit period"
    end

    test "updates habit_period within modal", %{conn: conn, habit_period: habit_period} do
      {:ok, show_live, _html} = live(conn, ~p"/habit_periods/#{habit_period}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Habit period"

      assert_patch(show_live, ~p"/habit_periods/#{habit_period}/show/edit")

      assert show_live
             |> form("#habit_period-form", habit_period: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#habit_period-form", habit_period: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/habit_periods/#{habit_period}")

      html = render(show_live)
      assert html =~ "Habit period updated successfully"
    end
  end
end
