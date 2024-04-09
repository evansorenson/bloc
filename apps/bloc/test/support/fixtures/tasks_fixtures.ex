defmodule Bloc.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bloc.Tasks` context.
  """

  @doc """
  Generate a task_list.
  """
  def task_list_fixture(attrs \\ %{}) do
    {:ok, task_list} =
      attrs
      |> Enum.into(%{
        color: "some color",
        position: 42,
        title: "some title"
      })
      |> Bloc.Tasks.create_task_list()

    task_list
  end
end
