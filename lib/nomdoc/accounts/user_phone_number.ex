defmodule Nomdoc.Accounts.UserPhoneNumber do
  @moduledoc false

  use Nomdoc, :schema

  schema "user_phone_numbers" do
    belongs_to :user, Nomdoc.Accounts.User
    field :value, :string

    timestamps()
  end
end
