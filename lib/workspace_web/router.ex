defmodule WorkspaceWeb.Router do
  use WorkspaceWeb, :router

  import WorkspaceWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WorkspaceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug WorkspaceWeb.PutSecureBrowserHeaders
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WorkspaceWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/log-in", LoginController, :new
    get "/oauth/google", OAuthController, :google
  end

  scope "/", WorkspaceWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", PageController, :home
    get "/inbox", InboxController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", WorkspaceWeb do
  #   pipe_through :api
  # end
end
