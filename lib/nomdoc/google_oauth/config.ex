defmodule Nomdoc.GoogleOAuth.Config do
  @moduledoc false

  @key Nomdoc.GoogleOAuth

  def adapter do
    Application.fetch_env!(:nomdoc, @key)[:adapter]
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
end
