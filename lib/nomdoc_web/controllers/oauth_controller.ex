defmodule NomdocWeb.OAuthController do
  use NomdocWeb, :controller

  alias Nomdoc.Accounts
  alias Nomdoc.GoogleOAuth
  alias NomdocWeb.UserAuth

  def google(%Plug.Conn{} = conn, params) do
    with {:ok, authorization_code} <- get_google_authorization_code(conn, params),
         {:ok, token} <- get_google_token(conn, authorization_code),
         {:ok, claims} <- get_google_userinfo(conn, token),
         maybe_user <- Accounts.get_user_by_google_id(claims["sub"]),
         user <- maybe_register_user(maybe_user, claims) do
      conn
      |> UserAuth.log_in_user(user)
      |> redirect(to: ~p"/")
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
      {:error, _reason} -> render(conn, :invalid_code)
    end
  end

  defp get_google_userinfo(conn, token) do
    case GoogleOAuth.userinfo(token) do
      {:ok, claims} -> {:ok, claims}
      {:error, _reason} -> render(conn, :invalid_code)
    end
  end

  defp maybe_register_user(nil, claims) do
    {:ok, user} = Accounts.register_user(%{google_id: claims["sub"], email_address: claims["email"]})

    user
  end

  defp maybe_register_user(user, _claims) do
    user
  end
end
