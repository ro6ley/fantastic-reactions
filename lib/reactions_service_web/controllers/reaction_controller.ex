defmodule ReactionsServiceWeb.ReactionController do
  use ReactionsServiceWeb, :controller

  alias ReactionsServiceWeb.ErrorView

  action_fallback ReactionsServiceWeb.FallbackController

  def save_reaction(conn, %{
        "action" => action,
        "content_id" => content_id,
        "reaction_type" => reaction_type,
        "type" => _type,
        "user_id" => user_id
      }) do
    # check if the content has exisiting reactions in the ETS Table
    case ets_lookup(content_id) do
      :none ->
        ets_insert({content_id, %{reaction_type => [user_id]}})
        render(conn, "response.json", response: "Saved")

      {content_id, content_reactions} ->
        # check if the reaction_type already exists
        if Map.has_key?(content_reactions, reaction_type) do
          users = content_reactions[reaction_type]

          case action do
            "add" ->
              if Enum.member?(users, user_id) do
                render(conn, "response.json", response: "Already reacted")
              else
                ets_insert(
                  {content_id, Map.put(content_reactions, reaction_type, [user_id | users])}
                )

                render(conn, "response.json", response: "Reaction added")
              end

            "remove" ->
              if Enum.member?(users, user_id) do
                users = List.delete(users, user_id)
                ets_insert({content_id, Map.put(content_reactions, reaction_type, users)})
                render(conn, "response.json", response: "Reaction removed")
              else
                render(conn, "response.json", response: "Already removed reaction")
              end
          end

        # new reaction_type
        else
          case action do
            "add" ->
              ets_insert({content_id, Map.put(content_reactions, reaction_type, [user_id])})
              render(conn, "response.json", response: "Reaction added")

            "remove" ->
              render(conn, "response.json", response: "Reaction does not exist")
          end
        end
    end
  end

  def reaction_count(conn, %{"content_id" => content_id}) do
    # check if content_id exists
    case ets_lookup(content_id) do
      {content_id, content_reactions} ->
        counts = Enum.map(content_reactions, fn {k, v} -> {k, length(v)} end)

        render(conn, "reactions_count.json", %{
          content_id: content_id,
          counts: Enum.into(counts, %{})
        })

      :none ->
        render(conn, ErrorView, "404.json")
    end
  end

  defp ets_lookup(key) do
    case :ets.lookup(:reactions_table, key) do
      [] -> :none
      [{content_id, content_reactions}] -> {content_id, content_reactions}
    end
  end

  defp ets_insert(reactions_data) do
    :ets.insert(:reactions_table, reactions_data)
  end
end
