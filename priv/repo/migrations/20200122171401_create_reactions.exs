defmodule ReactionsService.Repo.Migrations.CreateReactions do
  use Ecto.Migration

  def change do
    create table(:reactions) do
      add :type, :string
      add :action, :string
      add :content_id, :string
      add :user_id, :string
      add :reaction_type, :string

      timestamps()
    end

  end
end
