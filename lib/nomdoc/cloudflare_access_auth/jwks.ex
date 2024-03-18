defmodule Nomdoc.CloudflareAccessAuth.Jwks do
  @moduledoc false

  use JokenJwks.DefaultStrategyTemplate

  alias Nomdoc.CloudflareAccessAuth

  def init_opts(_opts) do
    [jwks_url: CloudflareAccessAuth.Config.jwks_url()]
  end
end
