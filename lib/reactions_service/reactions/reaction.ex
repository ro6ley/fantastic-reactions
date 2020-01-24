defmodule ReactionsService.Reactions.Reaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reactions" do
    field :action, :string
    field :content_id, :string
    field :reaction_type, :string
    field :type, :string
    field :user_id, :string

    timestamps()
  end

  @doc false
  def changeset(reaction, attrs) do
    reaction
    |> cast(attrs, [:type, :action, :content_id, :user_id, :reaction_type])
    |> validate_required([:type, :action, :content_id, :user_id, :reaction_type])
  end
end
