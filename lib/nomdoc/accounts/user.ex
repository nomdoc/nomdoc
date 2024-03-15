defmodule Nomdoc.Accounts.User do
  @moduledoc false

  use Nomdoc, :schema

  schema "users" do
    field :email_address, :string
    field :google_id, :string

    timestamps()
  end
end
