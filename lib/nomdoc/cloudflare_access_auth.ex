defmodule Nomdoc.CloudflareAccessAuth do
  @moduledoc false

  alias Nomdoc.CloudflareAccessAuth

  @callback verify_and_validate(token :: binary()) :: :ok | :error

  def verify_and_validate(token) do
    adapter().verify_and_validate(token)
  end

  defp adapter do
    CloudflareAccessAuth.Config.jwt_validator()
  end
end
