defmodule WorkspaceWeb.InboxController do
  @moduledoc false

  use WorkspaceWeb, :controller

  def index(%Plug.Conn{} = conn, _params) do
    render_react_app(conn, page_title: gettext("Inbox"))
  end
end
