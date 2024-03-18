defmodule Nomdoc.CloudflareAccessAuth.Config do
  @moduledoc false

  @key Nomdoc.CloudflareAccessAuth

  def jwks_url do
    Application.fetch_env!(:nomdoc, @key)[:jwks_url]
  end

  def jwt_validator do
    Application.fetch_env!(:nomdoc, @key)[:jwt_validator]
  end

  def jwt_iss do
    Application.fetch_env!(:nomdoc, @key)[:jwt_iss]
  end

  def jwt_aud do
    Application.fetch_env!(:nomdoc, @key)[:jwt_aud]
  end
end
