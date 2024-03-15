defmodule NomdocWeb.OAuthController do
  use NomdocWeb, :controller

  alias Nomdoc.GoogleOAuth

  def google(%Plug.Conn{} = conn, params) do
    with {:ok, authorization_code} <- get_google_authorization_code(conn, params),
         {:ok, token} <- get_google_token(conn, authorization_code) do
      profile = GoogleOAuth.profile(token)

      IO.inspect(profile)

      redirect(conn, to: ~p"/")
    end
  end

  defp get_google_authorization_code(conn, params) do
    if authorization_code = params["code"] do
      {:ok, authorization_code}
    else
      render(conn, :invalid_code)
    end
  end

  defp get_google_token(conn, authorization_code) do
    case GoogleOAuth.token(authorization_code, redirect_uri: "https://www.nomdoc.net:4001/oauth/google") do
      {:ok, token} -> {:ok, token}
      {:error, _error} -> render(conn, :invalid_code)
    end
  end
end
