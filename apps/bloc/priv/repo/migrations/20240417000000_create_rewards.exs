defmodule Bloc.Repo.Migrations.CreateRewards do
  use Ecto.Migration

  def change do
    create table(:rewards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :description, :string
      add :probability, :float, null: false
      add :active?, :boolean, default: true
      add :deleted?, :utc_datetime

      add :user_id, references(:users, on_delete: :nothing, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:rewards, [:user_id])
  end
end
