defmodule Nomdoc.GoogleOAuth.IdToken do
  @moduledoc false

  alias Nomdoc.GoogleOAuth

  @callback verify_and_validate(token :: binary()) :: :ok | :error

  def verify_and_validate(token) do
    adapter().verify_and_validate(token)
  end

  defp adapter do
    GoogleOAuth.Config.id_token_validator()
  end
end
