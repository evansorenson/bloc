defmodule Bloc.Factory do
  # with Ecto
  @moduledoc false
  use ExMachina.Ecto, repo: Bloc.Repo

  alias Bloc.Accounts.User

  def user(_context) do
    {:ok, user: insert(:user)}
  end

  def user_factory(attrs) do
    %{
      email: sequence(:email, &"email-#{&1}@example.com"),
      role: :user,
      password: valid_user_password()
    }
    |> merge_attributes(attrs)
    |> then(&User.registration_changeset(%User{}, &1))
    |> Ecto.Changeset.apply_changes()
  end

  def block(%{user: user}) do
    {:ok, block: insert(:block, user: user)}
  end

  def block_factory do
    %Bloc.Blocks.Block{
      title: sequence(:title, &"title-#{&1}"),
      start_time: DateTime.utc_now(),
      end_time: DateTime.add(DateTime.utc_now(), 1, :hour),
      user: build(:user)
    }
  end

  def habit(%{user: user}) do
    {:ok, habit: insert(:habit, user: user)}
  end

  def habit_factory do
    %Bloc.Habits.Habit{
      title: sequence(:title, &"title-#{&1}"),
      notes: "some notes",
      period_type: :daily,
      user: build(:user),
      start_time: nil,
      end_time: nil
    }
  end

  def task(%{user: user} = context) do
    {:ok, task: insert(:task, habit: context[:habit], user: user, task_list: context[:task_list])}
  end

  def task_factory do
    %Bloc.Tasks.Task{
      title: sequence(:title, &"title-#{&1}"),
      notes: "some notes",
      due_date: Date.utc_today(),
      user: build(:user),
      task_list: build(:task_list),
      habit: build(:habit)
    }
  end

  def task_list(%{user: user}) do
    {:ok, task_list: insert(:task_list, user: user)}
  end

  def task_list_factory do
    %Bloc.Tasks.TaskList{
      title: sequence(:title, &"title-#{&1}"),
      user: build(:user)
    }
  end

  def habit_task_factory do
    %Bloc.Tasks.Task{
      due_date: Date.utc_today(),
      habit: build(:habit),
      user: build(:user)
    }
  end

  def habit_day_factory do
    %Bloc.Habits.HabitDay{
      date: Date.utc_today(),
      completed_count: 1,
      completed?: true,
      habit: build(:habit),
      user: build(:user)
    }
  end

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
