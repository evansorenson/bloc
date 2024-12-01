defmodule Bloc.Repo.Migrations.CreateHabitDays do
  use Ecto.Migration

  def change do
    create table(:habit_days, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :date, null: false
      add :completed_count, :integer, default: 0
      add :completed?, :boolean, default: false
      add :habit_id, references(:habits, on_delete: :delete_all, type: :binary_id), null: false
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:habit_days, [:habit_id])
    create index(:habit_days, [:user_id])
    create unique_index(:habit_days, [:habit_id, :date])
  end
end
