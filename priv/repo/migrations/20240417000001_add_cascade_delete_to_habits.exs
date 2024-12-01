defmodule Bloc.Repo.Migrations.AddCascadeDeleteToHabits do
  use Ecto.Migration

  def up do
    drop constraint(:tasks, "tasks_habit_id_fkey")
    alter table(:tasks) do
      modify :habit_id, references(:habits, on_delete: :delete_all, type: :binary_id)
    end
  end

  def down do
    drop constraint(:tasks, "tasks_habit_id_fkey")
    alter table(:tasks) do
      modify :habit_id, references(:habits, on_delete: :nothing, type: :binary_id)
    end
  end
end
