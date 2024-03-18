defmodule Nomdoc.Repo.Migrations.CreateAccountsTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email_address, :string
      add :google_account_id, :string

      timestamps()
    end

    create unique_index(:users, [:email_address])
    create unique_index(:users, [:google_account_id])

    create table(:user_tokens) do
      add :user_id, :binary_id
      add :token, :string
      add :context, :string

      timestamps()
    end

    create index(:user_tokens, [:user_id])
    create unique_index(:user_tokens, [:context, :token])
  end
end
