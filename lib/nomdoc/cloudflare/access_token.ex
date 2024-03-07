defmodule Nomdoc.Cloudflare.AccessToken do
  @moduledoc false

  @callback verify_and_validate(token :: binary()) :: :ok | :error
end
