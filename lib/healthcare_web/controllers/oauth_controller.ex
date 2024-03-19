defmodule HealthcareWeb.OAuthController do
  use HealthcareWeb, :controller

  alias HealthcareWeb.UserAuth
  alias Nomdoc.Accounts
  alias Nomdoc.GoogleOAuth

  def google(%Plug.Conn{} = conn, params) do
    with {:ok, authorization_code} <- get_google_authorization_code(conn, params),
         {:ok, token} <- get_google_token(conn, authorization_code),
         {:ok, claims} <- get_google_userinfo(conn, token),
         {:ok, user} <- sync_user_by_google_account(conn, claims["email"], claims["sub"]) do
      conn
      |> UserAuth.log_in_user(user)
      |> redirect(to: ~p"/")
    end
  end

  defp get_google_authorization_code(conn, params) do
    if authorization_code = params["code"] do
      {:ok, authorization_code}
    else
      render(conn, :invalid_google_authorization_code)
    end
  end

  defp get_google_token(conn, authorization_code) do
    case GoogleOAuth.token(authorization_code, redirect_uri: UserAuth.google_oauth_redirect_uri()) do
      {:ok, token} -> {:ok, token}
      {:error, _reason} -> render(conn, :invalid_google_authorization_code)
    end
  end

  defp get_google_userinfo(conn, token) do
    case GoogleOAuth.userinfo(token) do
      {:ok, claims} -> {:ok, claims}
      {:error, _reason} -> render(conn, :invalid_google_authorization_code)
    end
  end

  defp sync_user_by_google_account(conn, email_address, google_account_id) do
    case Accounts.sync_user_by_google_account(email_address, google_account_id) do
      {:ok, user} -> {:ok, user}
      {:error, :invalid_google_account} -> render(conn, :invalid_google_account)
    end
  end
end
