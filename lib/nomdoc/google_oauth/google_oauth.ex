defmodule Nomdoc.GoogleOAuth do
  @moduledoc false

  alias Nomdoc.GoogleOAuth

  @callback authorization_url(Keyword.t()) :: binary()

  @callback token(binary(), Keyword.t()) :: {:ok, map()} | {:error, :invalid_authorization_code}

  @callback profile(map()) :: GoogleOAuth.GoogleAccount.t()

  def authorization_url(opts) do
    GoogleOAuth.Config.adapter().authorization_url(opts)
  end

  def token(authorization_code, opts) do
    GoogleOAuth.Config.adapter().token(authorization_code, opts)
  end

  def profile(token) do
    GoogleOAuth.Config.adapter().profile(token)
  end
end
