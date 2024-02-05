defmodule Nomdoc.Repo do
  use Ecto.Repo,
    otp_app: :nomdoc,
    adapter: Ecto.Adapters.Postgres
end

# See https://hexdocs.pm/geo_postgis/readme.html#examples
Postgrex.Types.define(
  Nomdoc.Repo.PostgrexTypes,
  [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
  json: Jason
)
