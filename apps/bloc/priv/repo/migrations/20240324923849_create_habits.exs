defmodule Bloc.Repo.Migrations.CreateHabits do
  use Ecto.Migration

  def change do
    create table(:habits, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :notes, :string
      add :period_type, :string
      add :deleted?, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:habits, [:user_id])
  end
end
