# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :example,
  ecto_repos: [Example.Repo]

# Configures the endpoint
config :example, ExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LBIElDrUNSPTsq1+z8kBYprY5unhlA10/hpABkkRo+iBVaIWo3UZap3ayZ3zXEtV",
  render_errors: [view: ExampleWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Example.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Example",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "SpNVevQh301beLI6sxzq4p0tp0rpODZV97aFLRbk+wjl/sShSpsgtb8MSgcH6tbA",
  serializer: Example.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
