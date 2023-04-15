# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :punchy_api, ecto_repos: [PunchyApi.Repo]

config :punchy_api, :data, truck_data_url: "https://data.sfgov.org/api/views/rqzj-sfat/rows.csv"

import_config "#{Mix.env()}.exs"
