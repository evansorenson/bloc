defmodule Bloc.Repo.Migrations.AddStreakToHabits do
  use Ecto.Migration

  def change do
    alter table(:habits) do
      add :streak, :integer, default: 0
    end
  end
end
