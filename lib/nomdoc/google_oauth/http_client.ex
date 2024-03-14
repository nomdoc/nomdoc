defmodule Nomdoc.GoogleOAuth.HttpClient do
  @moduledoc false

  @behaviour Nomdoc.GoogleOAuth

  alias Nomdoc.GoogleOAuth

  @doc """
  Creates the authorization request.

  See https://developers.google.com/identity/protocols/oauth2/web-server#creatingclient
  """
  def generate_authorization_url(opts) do
    {redirect_uri, opts} = Keyword.pop!(opts, :redirect_uri)
    {scopes, []} = Keyword.pop!(opts, :scopes)

    params = [
      client_id: GoogleOAuth.Config.client_id(),
      response_type: "code",
      redirect_uri: redirect_uri,
      scope: parse_scopes(scopes)
    ]

    query_params =
      Enum.into(params, %{})
      |> URI.encode_query(:rfc3986)

    "#{GoogleOAuth.Config.oauth_url()}?#{query_params}"
  end

  defp parse_scopes(scopes) do
    Enum.join(scopes, " ")
  end

  @doc """
  Retrieves Google OAuth token using authorization code.
  """
  def get_token(authorization_code, opts) do
    {redirect_uri, []} = Keyword.pop!(opts, :redirect_uri)

    params = [
      client_id: GoogleOAuth.Config.client_id(),
      client_secret: GoogleOAuth.Config.client_secret(),
      code: authorization_code,
      grant_type: "authorization_code",
      redirect_uri: redirect_uri
    ]

    case Req.post!(GoogleOAuth.Config.token_url(), form: params) do
      %Req.Response{status: 200} = res -> {:ok, res.body}
      _reply -> {:error, :invalid_authorization_code}
    end
  end

  @doc """
  Retrieves info from `id_token`.
  """
  def get_google_account(token) do
    {:ok, claims} = Joken.peek_claims(token["id_token"])

    GoogleOAuth.GoogleAccount.build(claims)
  end
end
