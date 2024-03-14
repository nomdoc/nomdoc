defmodule Nomdoc.Cloudflare.ApplicationToken do
  @moduledoc false

  alias Nomdoc.Cloudflare

  @callback verify_and_validate(token :: binary()) :: :ok | :error

  def verify_and_validate(token) do
    adapter().verify_and_validate(token)
  end

  defp adapter do
    Cloudflare.Config.application_token_validator()
  end
end
