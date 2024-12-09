defmodule Bloc.Repo.Migrations.AddParentIdToHabits do
  @moduledoc false
  use Ecto.Migration

  def change do
    alter table(:habits) do
      add :parent_id, references(:habits, on_delete: :delete_all, type: :uuid)
    end

    create index(:habits, [:parent_id])
  end
end
