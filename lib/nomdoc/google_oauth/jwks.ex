defmodule Nomdoc.GoogleOAuth.Jwks do
  @moduledoc false

  use JokenJwks.DefaultStrategyTemplate

  alias Nomdoc.GoogleOAuth

  def init_opts(_opts) do
    [jwks_url: GoogleOAuth.Config.jwks_url()]
  end
end
