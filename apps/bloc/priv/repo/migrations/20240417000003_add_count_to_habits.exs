defmodule Bloc.Repo.Migrations.AddCountToHabits do
  use Ecto.Migration

  def change do
    alter table(:habits) do
      add :required_count, :integer, default: 1
    end
  end
end
