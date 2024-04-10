defmodule Bloc.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :complete?, :utc_datetime
      add :active?, :utc_datetime
      add :deleted?, :utc_datetime
      add :due_date, :date
      add :title, :string, null: false
      add :notes, :string
      add :position, :integer

      add :habit_id, references(:habits, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id), null: false
      add :parent_id, references(:tasks, on_delete: :nothing, type: :binary_id)
      add :task_list_id, references(:task_lists, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:tasks, [:habit_id])
    create index(:tasks, [:user_id])
    create index(:tasks, [:parent_id])
    create index(:tasks, [:task_list_id])
  end
end
