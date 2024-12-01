defmodule Bloc.Repo.Migrations.AddDaysToHabits do
  use Ecto.Migration

  def change do
    alter table(:habits) do
      add :days, {:array, :integer}, default: [1, 2, 3, 4, 5, 6, 7]
    end
  end
end
