defmodule NomdocWeb.PutSecureBrowserHeaders do
  @moduledoc false

  @behaviour Plug

  @impl Plug
  def init(opts) do
    opts
  end

  @impl Plug
  def call(%Plug.Conn{} = conn, _opts) do
    nonce = generate_nonce()
    csp_headers = csp_headers(nonce)

    conn
    |> Plug.Conn.assign(:csp_nonce_value, nonce)
    |> Phoenix.Controller.put_secure_browser_headers(csp_headers)
  end

  def csp_headers(nonce) do
    # Values taken from https://web.dev/articles/strict-csp
    csp_content = """
    object-src 'none';
    script-src 'nonce-#{nonce}' 'strict-dynamic';
    base-uri 'none';
    """

    %{"content-security-policy" => String.replace(csp_content, "\n", "")}
  end

  defp generate_nonce do
    :crypto.strong_rand_bytes(10)
    |> Base.url_encode64(padding: false)
  end
end
