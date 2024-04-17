defmodule Bloc.TasksTest do
  alias Bloc.Scope
  use Bloc.DataCase

  alias Bloc.Tasks
  alias Bloc.Tasks.Task

  setup [:user, :habit, :task_list, :task]

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
      assert [queried_task] = Tasks.list_tasks(%Scope{current_user_id: user.id})
      assert queried_task.id == task.id
    end

    test "get_task!/1 returns the task with given id", %{
      task: task
    } do
      queried_task = Tasks.get_task!(task.id)
      assert queried_task.id == task.id
    end

    test "create_task/1 with valid data creates a task", %{
      user: user,
      habit: habit,
      task_list: task_list
    } do
      valid_attrs = %{
        title: "some title",
        due_date: ~D[2024-03-29],
        complete?: ~U[2024-03-25 17:34:00Z],
        active?: ~U[2024-03-25 17:34:00Z],
        deleted?: ~U[2024-03-25 17:34:00Z],
        user_id: user.id,
        habit_id: habit.id,
        task_list_id: task_list.id
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

    test "create task with parent task", %{
      user: user,
      habit: habit,
      task_list: task_list,
      task: parent_task
    } do
      {:ok, task} =
        Tasks.create_task(%{
          title: "subtask",
          due_date: ~D[2024-03-29],
          complete?: ~U[2024-03-25 17:34:00Z],
          active?: ~U[2024-03-25 17:34:00Z],
          deleted?: ~U[2024-03-25 17:34:00Z],
          user_id: user.id,
          habit_id: habit.id,
          task_list_id: task_list.id,
          parent_id: parent_task.id
        })

      assert task.parent_id == parent_task.id
    end

    test "task must be assigned to parent task or task list", %{
      user: user,
      habit: habit
    } do
      invalid_attrs = %{
        title: "some title",
        due_date: ~D[2024-03-29],
        complete?: ~U[2024-03-25 17:34:00Z],
        active?: ~U[2024-03-25 17:34:00Z],
        deleted?: ~U[2024-03-25 17:34:00Z],
        user_id: user.id,
        habit_id: habit.id
      }

      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(invalid_attrs)
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

  describe "task_lists" do
    alias Bloc.Tasks.TaskList

    @list_invalid_attrs %{position: nil, title: nil, color: nil}

    test "list_task_lists/0 returns all task_lists", %{task_list: task_list} do
      [queried_task_list] = Tasks.list_task_lists(%Scope{current_user_id: task_list.user_id})
      assert task_list.id == queried_task_list.id
    end

    test "get_task_list!/1 returns the task_list with given id", %{task_list: task_list} do
      queried_task_list = Tasks.get_task_list!(task_list.id)
      assert queried_task_list.id == task_list.id
    end

    test "create_task_list/1 with valid data creates a task_list", %{user: user} do
      valid_attrs = %{position: 42, title: "some title", color: "some color", user_id: user.id}

      assert {:ok, %TaskList{} = task_list} = Tasks.create_task_list(valid_attrs)
      assert task_list.position == 42
      assert task_list.title == "some title"
      assert task_list.color == "some color"
    end

    test "create_task_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task_list(@list_invalid_attrs)
    end

    test "update_task_list/2 with valid data updates the task_list", %{task_list: task_list} do
      update_attrs = %{position: 43, title: "some updated title", color: "some updated color"}

      assert {:ok, %TaskList{} = task_list} = Tasks.update_task_list(task_list, update_attrs)
      assert task_list.position == 43
      assert task_list.title == "some updated title"
      assert task_list.color == "some updated color"
    end

    test "update_task_list/2 with invalid data returns error changeset", %{task_list: task_list} do
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task_list(task_list, @list_invalid_attrs)
      not_updated_task_list = Tasks.get_task_list!(task_list.id)
      assert not_updated_task_list.updated_at == task_list.updated_at
    end

    test "delete_task_list/1 deletes the task_list", %{task_list: task_list} do
      assert {:ok, %TaskList{}} = Tasks.delete_task_list(task_list)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task_list!(task_list.id) end
    end

    test "change_task_list/1 returns a task_list changeset", %{task_list: task_list} do
      assert %Ecto.Changeset{} = Tasks.change_task_list(task_list)
    end
  end
end
