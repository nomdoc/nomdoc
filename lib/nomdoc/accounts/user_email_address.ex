defmodule Nomdoc.Accounts.UserEmailAddress do
  @moduledoc false

  use Nomdoc, :schema

  schema "user_email_addresses" do
    belongs_to :user, Nomdoc.Accounts.User
    field :value, :string

    timestamps()
  end
end
