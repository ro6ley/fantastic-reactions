defmodule ReactionsServiceWeb.Router do
  use ReactionsServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReactionsServiceWeb do
    pipe_through :api
  end
end
