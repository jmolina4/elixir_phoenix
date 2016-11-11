defmodule Dogfamily.Repo.Migrations.CreateResidence do
  use Ecto.Migration

  def change do
    create table(:residences) do
      add :name, :string

      timestamps()
    end

  end
end
