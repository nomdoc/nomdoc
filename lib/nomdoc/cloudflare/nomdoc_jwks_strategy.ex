defmodule Nomdoc.Cloudflare.JwksStrategy do
  @moduledoc false

  use JokenJwks.DefaultStrategyTemplate

  alias Nomdoc.Cloudflare

  def init_opts(_opts) do
    [jwks_url: Cloudflare.Config.jwks_url()]
  end
end
