defmodule ReactionsService.Repo do
  use Ecto.Repo,
    otp_app: :reactions_service,
    adapter: Ecto.Adapters.Postgres
end
