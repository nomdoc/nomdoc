defmodule NomdocWeb.PageController do
  use NomdocWeb, :controller

  def home(%Plug.Conn{} = conn, _params) do
    render(conn, :home)
  end
end
