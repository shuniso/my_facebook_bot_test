# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :fbot, Fbot.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: System.get_env("FBOT_SECRET_KEYBASE"),
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Fbot.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :fbot,
  fb_url: "https://graph.facebook.com/v2.6/me/messages?access_token=",
  fb_token: System.get_env("FB_BOT_TOKEN"),
  gyazo_upload_url: "https://upload.gyazo.com/api/upload",
  gyazo_token: System.get_env("GYAZO_TOKEN"),
  zen_api_url: "https://api.github.com/zen",
  lgtm_url: "http://www.lgtm.in/g",
  cat_url: "http://thecatapi.com/api/images/get",
  cat_token: System.get_env("CAT_TOKEN"),
  dcm_key: System.get_env("DOCOMO_DIALOGUE_API_KEY"),
  excuse_url: "http://programmingexcuses.com/",
  ul_key: System.get_env("UL_API_KEY"),
  ul_decompose: "https://chatbot-api.userlocal.jp/api/decompose",
  ul_chat: "https://chatbot-api.userlocal.jp/api/chat",
  ul_name: "https://chatbot-api.userlocal.jp/api/name"
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
