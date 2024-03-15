defmodule Nomdoc.GoogleOAuth.Config do
  @moduledoc false

  @key Nomdoc.GoogleOAuth

  def adapter do
    Application.fetch_env!(:nomdoc, @key)[:adapter]
  end

  def jwks_url do
    Application.fetch_env!(:nomdoc, @key)[:jwks_url]
  end

  def oauth_url do
    Application.fetch_env!(:nomdoc, @key)[:oauth_url]
  end

  def token_url do
    Application.fetch_env!(:nomdoc, @key)[:token_url]
  end

  def client_id do
    Application.fetch_env!(:nomdoc, @key)[:client_id]
  end

  def client_secret do
    Application.fetch_env!(:nomdoc, @key)[:client_secret]
  end

  def id_token_validator do
    Application.fetch_env!(:nomdoc, @key)[:id_token_validator]
  end

  def id_token_iss do
    Application.fetch_env!(:nomdoc, @key)[:id_token_iss]
  end
end
