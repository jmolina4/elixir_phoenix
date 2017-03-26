defmodule Dogfamily.Repo.Migrations.CreateBrand do
  use Ecto.Migration

  def change do
  	create table(:brands) do
      add :name, :string
      add :description, :string      

      timestamps()
    end
  end
end