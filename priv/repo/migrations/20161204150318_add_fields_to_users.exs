defmodule Rmo.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
      add :first_name, :string
      add :last_name, :string
      add :date_of_birth, :date
      add :gender, :string
      add :gender_preference, :string
      add :status, :string
      add :location, :string
      add :description, :string
    end
    create unique_index(:users, [:username])

  end
end
