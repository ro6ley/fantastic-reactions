defmodule ReactionsServiceWeb.ReactionView do
  use ReactionsServiceWeb, :view
  alias ReactionsServiceWeb.ReactionView

  def render("index.json", %{reactions: reactions}) do
    %{data: render_many(reactions, ReactionView, "reaction.json")}
  end

  def render("show.json", %{reaction: reaction}) do
    %{data: render_one(reaction, ReactionView, "reaction.json")}
  end

  def render("reaction.json", %{reaction: reaction}) do
    %{id: reaction.id,
      type: reaction.type,
      action: reaction.action,
      content_id: reaction.content_id,
      user_id: reaction.user_id,
      reaction_type: reaction.reaction_type}
  end
end
