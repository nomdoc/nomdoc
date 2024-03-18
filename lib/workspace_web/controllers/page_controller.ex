defmodule WorkspaceWeb.PageController do
  use WorkspaceWeb, :controller

  def home(%Plug.Conn{} = conn, _params) do
    redirect(conn, to: ~p"/inbox")
  end
end
