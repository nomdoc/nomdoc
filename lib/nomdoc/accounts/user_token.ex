defmodule Nomdoc.Accounts.UserToken do
  @moduledoc false

  use Nomdoc, :schema

  schema "user_tokens" do
    field :token, :binary
    field :context, :string
    field :sent_to, :string
    belongs_to :user, Nomdoc.Accounts.User

    timestamps()
  end
end
