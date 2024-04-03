defmodule Friendsforever.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, size: 20, null: false
      add :bio, :string, size: 320
      add :pronouns, :string, size: 20
      add :website, :string, size: 50
      add :birthday, :date
    end
  end
end
