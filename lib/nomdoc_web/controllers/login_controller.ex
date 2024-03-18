defmodule NomdocWeb.LoginController do
  use NomdocWeb, :controller

  alias Nomdoc.GoogleOAuth
  alias NomdocWeb.UserAuth

  def new(%Plug.Conn{} = conn, _params) do
    google_oauth_url =
      GoogleOAuth.authorization_url(
        redirect_uri: UserAuth.google_oauth_redirect_uri(),
        scopes: ["https://www.googleapis.com/auth/userinfo.email", "https://www.googleapis.com/auth/userinfo.profile"]
      )

    render(conn, :new, google_oauth_url: google_oauth_url)
  end
end
