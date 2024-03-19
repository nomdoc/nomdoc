defmodule Nomdoc.Accounts.User do
  @moduledoc false

  use Nomdoc, :schema

  schema "users" do
    field :google_account_id, :string
    field :cloudflare_access_user_id, :string
    has_many :phone_numbers, Nomdoc.Accounts.UserPhoneNumber
    has_many :email_addresses, Nomdoc.Accounts.UserEmailAddress

    timestamps()
  end
end
