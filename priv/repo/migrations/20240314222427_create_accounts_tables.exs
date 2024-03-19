defmodule Nomdoc.Repo.Migrations.CreateAccountsTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :google_account_id, :string
      add :cloudflare_access_user_id, :string

      timestamps()
    end

    create unique_index(:users, [:google_account_id])
    create unique_index(:users, [:cloudflare_access_user_id])

    create table(:user_email_addresses) do
      add :user_id, :binary_id
      add :value, :string

      timestamps()
    end

    create unique_index(:user_email_addresses, [:value])

    create table(:user_phone_numbers) do
      add :user_id, :binary_id
      add :value, :string

      timestamps()
    end

    create unique_index(:user_phone_numbers, [:value])

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
