defmodule Bloc.Repo.Migrations.CreateHabitPeriods do
  use Ecto.Migration

  def change do
    create table(:habit_periods, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :period_type, :string
      add :value, :integer
      add :goal, :integer
      add :is_complete, :naive_datetime
      add :is_active, :naive_datetime
      add :unit, :string
      add :date, :date
      add :habit_id, references(:habits, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:habit_periods, [:habit_id])
  end
end
