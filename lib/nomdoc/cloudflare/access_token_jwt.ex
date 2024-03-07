defmodule Nomdoc.Cloudflare.AccessTokenJwt do
  @moduledoc false

  # @behaviour Nomdoc.Cloudflare.AccessToken

  # no signer
  # use Joken.Config, default_signer: nil

  # This hook implements a before_verify callback that checks whether it has a signer configuration
  # cached. If it does not, it tries to fetch it from the jwks_url.
  # add_hook(JokenJwks, jwks_url: "https://someurl.com")

  # @impl Joken.Config
  # def token_config do
  #  default_claims(skip: [:aud, :iss])
  #  |> add_claim("roles", nil, &(&1 in ["admin", "user"]))
  #  |> add_claim("iss", nil, &(&1 == "some server iss"))
  #  |> add_claim("aud", nil, &(&1 == "some server aud"))
  # end
end
