defmodule Dogfamily.Repo.Migrations.AddDogPhoto do
  use Ecto.Migration

  def change do
    alter table(:dogs) do
      add :photo, :string
    end
  end
end
