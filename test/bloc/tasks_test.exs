defmodule Bloc.TasksTest do
  use Bloc.DataCase

  alias Bloc.Scope
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

    test "task does not have to be assigned to parent task or task list or habit", %{
      user: user
    } do
      invalid_attrs = %{
        title: "some title",
        due_date: ~D[2024-03-29],
        complete?: ~U[2024-03-25 17:34:00Z],
        active?: ~U[2024-03-25 17:34:00Z],
        deleted?: ~U[2024-03-25 17:34:00Z],
        user_id: user.id
      }

      assert {:ok, %Task{} = task} = Tasks.create_task(invalid_attrs)
      refute task.parent_id
      refute task.task_list_id
      refute task.habit_id
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

    setup do
      user = insert(:user)
      scope = %Scope{current_user_id: user.id}
      {:ok, user: user, scope: scope}
    end

    test "list_task_lists/1 returns all task_lists for user", %{user: user, scope: scope} do
      task_list = insert(:task_list, user_id: user.id)
      assert Tasks.list_task_lists(scope) == [task_list]
    end

    test "get_task_list!/2 returns the task_list with given id", %{user: user, scope: scope} do
      task_list = insert(:task_list, user_id: user.id)
      assert Tasks.get_task_list!(task_list.id, scope) == task_list
    end

    test "create_task_list/2 with valid data creates a task_list", %{scope: scope} do
      valid_attrs = %{title: "some title", position: 42}

      assert {:ok, %TaskList{} = task_list} = Tasks.create_task_list(valid_attrs, scope)
      assert task_list.title == "some title"
      assert task_list.position == 42
      assert task_list.user_id == scope.current_user_id
    end

    test "create_task_list/2 with invalid data returns error changeset", %{scope: scope} do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task_list(@invalid_attrs, scope)
    end

    test "update_task_list/3 with valid data updates the task_list", %{user: user, scope: scope} do
      task_list = insert(:task_list, user_id: user.id)
      update_attrs = %{title: "some updated title", position: 43}

      assert {:ok, %TaskList{} = task_list} = Tasks.update_task_list(task_list, update_attrs, scope)
      assert task_list.title == "some updated title"
      assert task_list.position == 43
    end

    test "update_task_list/3 with invalid data returns error changeset", %{user: user, scope: scope} do
      task_list = insert(:task_list, user_id: user.id)
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task_list(task_list, @invalid_attrs, scope)
      assert task_list == Tasks.get_task_list!(task_list.id, scope)
    end

    test "delete_task_list/2 deletes the task_list", %{user: user, scope: scope} do
      task_list = insert(:task_list, user_id: user.id)
      assert {:ok, %TaskList{}} = Tasks.delete_task_list(task_list, scope)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task_list!(task_list.id, scope) end
    end

    test "change_task_list/1 returns a task_list changeset", %{task_list: task_list} do
      assert %Ecto.Changeset{} = Tasks.change_task_list(task_list)
    end
  end
end
