defmodule UserApiV3.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :middle_name, :string
      add :last_name, :string
      add :phone, :string
      add :birthdate, :string
      add :id_auth0, :string
      add :zone, :string
      add :language, :string
      add :photo, :string

      timestamps()
    end
  end
end
