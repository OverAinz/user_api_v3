# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :user_api_v3,
  ecto_repos: [UserApiV3.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :user_api_v3, UserApiV3Web.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: UserApiV3Web.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: UserApiV3.PubSub,
  live_view: [signing_salt: "T0kKQh6L"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

#config for guardian...
config :auth_me, AuthMe.UserManager.Guardian,
  issuer: "user_api_v3",
  secret_key: "t1djZWxwEBsBiQwguZeHR93zBnLbaq6EOJ0EKu5TUDd5ujSKLwHJPuqtPE7dN/YU"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
