defmodule Bloc.Repo.Migrations.TaskEstimate do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add(:estimated_minutes, :integer)
    end
  end
end
