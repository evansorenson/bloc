defmodule Bloc.TasksTest do
  use Bloc.DataCase

  alias Bloc.Tasks
  alias Bloc.Tasks.Task

  setup [:user, :habit, :task]

  describe "tasks" do
    @invalid_attrs %{
      due_date: nil,
      complete?: nil,
      active?: nil
    }

    test "list_tasks/0 returns all tasks", %{
      user: user,
      task: task
    } do
      assert [queried_task] = Tasks.list_tasks(user)
      assert load_task(queried_task) == task
    end

    test "get_task!/1 returns the task with given id", %{
      task: task
    } do
      assert Tasks.get_task!(task.id) |> load_task() == task
    end

    test "create_task/1 with valid data creates a task", %{
      user: user,
      task: task
    } do
      valid_attrs = %{
        title: "some title",
        due_date: ~D[2024-03-29],
        complete?: ~U[2024-03-25 17:34:00Z],
        active?: ~U[2024-03-25 17:34:00Z],
        deleted?: ~U[2024-03-25 17:34:00Z],
        user_id: user.id,
        habit_id: task.habit_id
      }

      assert {:ok, %Task{} = task} = Tasks.create_task(valid_attrs)
      assert task.title == "some title"
      assert task.user_id == user.id
      assert task.habit_id == task.habit_id
      assert task.due_date == ~D[2024-03-29]
      assert task.complete? == ~U[2024-03-25 17:34:00Z]
      assert task.active? == ~U[2024-03-25 17:34:00Z]
      assert task.deleted? == ~U[2024-03-25 17:34:00Z]
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task", %{
      task: task
    } do
      update_attrs = %{
        title: "some updated title",
        notes: "some updated notes",
        due_date: ~D[2024-03-30],
        complete?: ~U[2024-03-25 17:34:00Z],
        active?: ~U[2024-03-25 17:34:00Z],
        deleted?: ~U[2024-03-25 17:34:00Z]
      }

      assert {:ok, %Task{} = task} = Tasks.update_task(task, update_attrs)

      assert task.title == "some updated title"
      assert task.notes == "some updated notes"
      assert task.due_date == ~D[2024-03-30]
      assert task.complete? == ~U[2024-03-25 17:34:00Z]
      assert task.active? == ~U[2024-03-25 17:34:00Z]
      assert task.deleted? == ~U[2024-03-25 17:34:00Z]
    end

    test "delete_task/1 deletes the task", %{task: task} do
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset", %{task: task} do
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end

  defp load_task(task) do
    task |> Repo.preload([habit: [:user], user: []], force: true)
  end
end
