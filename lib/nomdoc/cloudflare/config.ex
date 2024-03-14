defmodule Nomdoc.Cloudflare.Config do
  @moduledoc false

  @key Nomdoc.Cloudflare

  def jwks_url do
    Application.fetch_env!(:nomdoc, @key)[:jwks_url]
  end

  def application_token_validator do
    Application.fetch_env!(:nomdoc, @key)[:application_token_validator]
  end

  def application_token_iss do
    Application.fetch_env!(:nomdoc, @key)[:application_token_iss]
  end

  def application_token_aud do
    Application.fetch_env!(:nomdoc, @key)[:application_token_aud]
  end
end
