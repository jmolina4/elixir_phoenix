defmodule Dogfamily.Repo.Migrations.CreateDog do
  use Ecto.Migration

  def change do
    create table(:dogs) do
      add :name, :string
      add :age, :integer
      add :residence_id, references(:residences)

      timestamps()
    end

    create index(:dogs, [:residence_id])
  end
end
