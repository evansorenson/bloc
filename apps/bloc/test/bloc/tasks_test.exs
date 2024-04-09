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

  describe "task_lists" do
    alias Bloc.Tasks.TaskList

    import Bloc.TasksFixtures

    @invalid_attrs %{position: nil, title: nil, color: nil}

    test "list_task_lists/0 returns all task_lists" do
      task_list = task_list_fixture()
      assert Tasks.list_task_lists() == [task_list]
    end

    test "get_task_list!/1 returns the task_list with given id" do
      task_list = task_list_fixture()
      assert Tasks.get_task_list!(task_list.id) == task_list
    end

    test "create_task_list/1 with valid data creates a task_list" do
      valid_attrs = %{position: 42, title: "some title", color: "some color"}

      assert {:ok, %TaskList{} = task_list} = Tasks.create_task_list(valid_attrs)
      assert task_list.position == 42
      assert task_list.title == "some title"
      assert task_list.color == "some color"
    end

    test "create_task_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task_list(@invalid_attrs)
    end

    test "update_task_list/2 with valid data updates the task_list" do
      task_list = task_list_fixture()
      update_attrs = %{position: 43, title: "some updated title", color: "some updated color"}

      assert {:ok, %TaskList{} = task_list} = Tasks.update_task_list(task_list, update_attrs)
      assert task_list.position == 43
      assert task_list.title == "some updated title"
      assert task_list.color == "some updated color"
    end

    test "update_task_list/2 with invalid data returns error changeset" do
      task_list = task_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task_list(task_list, @invalid_attrs)
      assert task_list == Tasks.get_task_list!(task_list.id)
    end

    test "delete_task_list/1 deletes the task_list" do
      task_list = task_list_fixture()
      assert {:ok, %TaskList{}} = Tasks.delete_task_list(task_list)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task_list!(task_list.id) end
    end

    test "change_task_list/1 returns a task_list changeset" do
      task_list = task_list_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task_list(task_list)
    end
  end
end
