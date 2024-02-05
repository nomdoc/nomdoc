defmodule WorkspaceWeb.Router do
  use WorkspaceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WorkspaceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WorkspaceWeb do
    pipe_through :browser

    get "/inbox", InboxController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", WorkspaceWeb do
  #   pipe_through :api
  # end
end
