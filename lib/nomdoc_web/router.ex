defmodule NomdocWeb.Router do
  use NomdocWeb, :router

  import NomdocWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NomdocWeb.Layouts, :root}
    plug :protect_from_forgery
    plug NomdocWeb.PutSecureBrowserHeaders
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NomdocWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", NomdocWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/log-in", LoginController, :new
    get "/oauth/google", OAuthController, :google
  end

  # Other scopes may use custom stacks.
  # scope "/api", NomdocWeb do
  #   pipe_through :api
  # end
end
