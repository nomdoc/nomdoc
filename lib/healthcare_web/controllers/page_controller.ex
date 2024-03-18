defmodule HealthcareWeb.PageController do
  use HealthcareWeb, :controller

  def home(%Plug.Conn{} = conn, _params) do
    render(conn, :home)
  end
end
