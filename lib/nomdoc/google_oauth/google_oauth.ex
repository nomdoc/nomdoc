defmodule Nomdoc.GoogleOAuth do
  @moduledoc false

  alias Nomdoc.GoogleOAuth

  @callback generate_authorization_url(Keyword.t()) :: binary()

  @callback get_token(binary(), Keyword.t()) :: {:ok, map()} | {:error, :invalid_authorization_code}

  @callback get_google_account(map()) :: GoogleOAuth.GoogleAccount.t()

  def generate_authorization_url(opts) do
    GoogleOAuth.Config.adapter().generate_authorization_url(opts)
  end

  def get_token(authorization_code, opts) do
    GoogleOAuth.Config.adapter().get_token(authorization_code, opts)
  end

  def get_google_account(token) do
    GoogleOAuth.Config.adapter().get_google_account(token)
  end
end
