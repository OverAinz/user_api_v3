import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :user_api_v3, UserApiV3.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "database",
  database: "user_api_v3_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :user_api_v3, UserApiV3Web.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "IDHg/fCrziCMOKEn8d6l9PQBkuikjPkFAUgZKpGq5Lbb3qPyTgwgVlbjK2WuSWw+",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
