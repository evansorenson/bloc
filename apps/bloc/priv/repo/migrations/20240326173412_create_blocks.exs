defmodule Bloc.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string, null: false
      add :start_time, :utc_datetime, null: false
      add :end_time, :utc_datetime, null: false
      add :user_id, references(:users, on_delete: :nothing, type: :uuid), null: false

      timestamps()
    end

    create index(:blocks, [:user_id])
  end
end
