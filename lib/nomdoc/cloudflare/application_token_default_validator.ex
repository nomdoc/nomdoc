defmodule Nomdoc.Cloudflare.ApplicationTokenDefaultValidator do
  @moduledoc """
  Validates the application token included in the request as a
  `Cf-Access-Jwt-Assertion` request header and as a `CF_Authorization` cookie.

  For more info, see
  https://developers.cloudflare.com/cloudflare-one/identity/authorization-cookie/validating-json/.

  **JWT Payload Sample**

  ```json
    {
      "aud": [
        "35889312e2ad1658fedfcb1369191fe4d647163c63116ef1bbdf14b4f2464772"
      ],
      "email": "daniel@nomdoc.com",
      "exp": 1710405850,
      "iat": 1710384250,
      "nbf": 1710384250,
      "iss": "https://nomdoc.cloudflareaccess.com",
      "type": "app",
      "identity_nonce": "gfRh5DoSpErc3ntV",
      "sub": "37b2fc1b-c4d6-53c2-95e7-96b3af4a9a32",
      "country": "MY"
    }
  ```
  """

  use Joken.Config, default_signer: nil

  add_hook(JokenJwks, strategy: Nomdoc.Cloudflare.JwksStrategy)

  @nomdoc_console_aud_tag "35889312e2ad1658fedfcb1369191fe4d647163c63116ef1bbdf14b4f2464772"

  @impl Joken.Config
  def token_config do
    default_claims(skip: [:aud, :iss, :jti])
    |> add_claim("iss", nil, &(&1 == "https://nomdoc.cloudflareaccess.com"))
    |> add_claim("aud", nil, &(is_list(&1) && @nomdoc_console_aud_tag in &1))
    |> add_claim("email", nil, &is_binary/1)
  end
end
