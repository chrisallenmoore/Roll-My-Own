# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rmo,
  ecto_repos: [Rmo.Repo]

# Configures the endpoint
config :rmo, Rmo.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "X8ysjt8ltKDIifdf2dYnC1QYJyMDbhgndHZKhP1ygw+TXyeDh8oRK01ZTPRE9GZf",
  render_errors: [view: Rmo.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rmo.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :scrivener_html,
 routes_helper: Rmo.Router.Helpers

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
