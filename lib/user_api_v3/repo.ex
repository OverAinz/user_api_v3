defmodule UserApiV3.Repo do
  use Ecto.Repo,
    otp_app: :user_api_v3,
    adapter: Ecto.Adapters.Postgres
end
