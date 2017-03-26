# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dogfamily,
  ecto_repos: [Dogfamily.Repo]

# Configures the endpoint
config :dogfamily, Dogfamily.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+8I0iStZyPGCfmjNeL81ULbKLIXmMNK7cDEjZ9s1qjEfIm/aSti3L4/m1nUukrYk",
  render_errors: [view: Dogfamily.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dogfamily.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Dogfamily",
  ttl: { 30, :days },
  allowed_drift: 2000,
  secret_key: "MHcCAQEEIBf2rzY2dTtwPUtOOIMqNWhaxbcJ3AkjCSCz4TTy/C6coAoGCCqGSM49AwEHoUQDQgAE1x8JaccSw7/SmfGtn14y1lbLSGAxmt++cYDnXFCA+8b9t/gK7/e4JOFjIfmOV5yELiwkp1/n411RsDh35JdLjA==",
  serializer: Dogfamily.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
