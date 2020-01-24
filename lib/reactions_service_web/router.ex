defmodule ReactionsServiceWeb.Router do
  use ReactionsServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReactionsServiceWeb do
    pipe_through :api
    # receive an action
    post "/reactions", ReactionController, :save_reaction

    # reaction count
    get "/reaction_counts/:content_id", ReactionController, :reaction_count
  end
end
