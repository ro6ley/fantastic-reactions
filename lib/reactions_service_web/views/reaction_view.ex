defmodule ReactionsServiceWeb.ReactionView do
  use ReactionsServiceWeb, :view

  def render("reactions_count.json", counts_data) do
    %{
      content_id: counts_data.content_id,
      reaction_count: counts_data.counts
    }
  end

  def render("response.json", %{response: response}) do
    %{msg: response}
  end
end
