defmodule Fbot.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :m, :text

      timestamps
    end

  end
end
