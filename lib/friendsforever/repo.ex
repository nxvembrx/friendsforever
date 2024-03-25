defmodule Friendsforever.Repo do
  use Ecto.Repo,
    otp_app: :friendsforever,
    adapter: Ecto.Adapters.Postgres
end
