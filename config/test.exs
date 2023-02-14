import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :fuel_calculator, FuelCalculator.Repo,
  username: "postgres",
  password: "root",
  hostname: "localhost",
  database: "fuel_calculator_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fuel_calculator, FuelCalculatorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5HNgqlN8GOvr4f2FeidOrXZNLh6G0fhyj0KzsVEOV/GFe3tN6UEy3n3PBaXtG7G8",
  server: false

# In test we don't send emails.
config :fuel_calculator, FuelCalculator.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
