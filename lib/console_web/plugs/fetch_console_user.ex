defmodule ConsoleWeb.FetchConsoleUser do
  @moduledoc false

  @behaviour Plug

  @impl Plug
  def init(opts) do
    opts
  end

  @impl Plug
  def call(%Plug.Conn{} = conn, _opts) do
    IO.inspect(conn.req_cookies)

    conn
  end
end
