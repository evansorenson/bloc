defmodule Bloc.Repo.Migrations.CreateRewardHistory do
  use Ecto.Migration

  def change do
    create table(:reward_history, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :reward_id, references(:rewards, on_delete: :nothing, type: :binary_id), null: false
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id), null: false
      add :task_id, references(:tasks, on_delete: :nothing, type: :binary_id)
      add :redeemed_at, :utc_datetime
      add :received_at, :utc_datetime, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:reward_history, [:user_id])
    create index(:reward_history, [:reward_id])
    create index(:reward_history, [:task_id])
  end
end
