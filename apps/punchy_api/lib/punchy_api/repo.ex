defmodule PunchyApi.Repo do
  use Ecto.Repo,
    otp_app: :punchy_api,
    adapter: Ecto.Adapters.Postgres
end
