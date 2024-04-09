defmodule Bloc.Repo.Migrations.CreateTaskLists do
  use Ecto.Migration

  def change do
    create table(:task_lists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :position, :integer
      add :color, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:task_lists, [:user_id])
  end
end
