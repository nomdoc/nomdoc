defmodule Nomdoc.Accounts do
  @moduledoc false

  import Ecto.Changeset
  import Ecto.Query
  import Nomdoc.ChangesetHelpers

  alias Nomdoc.Accounts.User
  alias Nomdoc.Accounts.UserEmailAddress
  alias Nomdoc.Accounts.UserPhoneNumber
  alias Nomdoc.Accounts.UserToken
  alias Nomdoc.Repo

  @session_validity_in_days 60

  @doc """
  Gets a user by email address.

  ## Examples

      iex> get_user_by_email_address("user@example.com")
      %User{}

      iex> get_user_by_email_address("user@example.com")
      nil

  """
  def get_user_by_email_address(email_address) do
    email_address = Repo.get_by(UserEmailAddress, value: email_address)

    email_address && Repo.get(User, email_address.user_id)
  end

  @doc """
  Gets a user by Google Account ID.

  ## Examples

      iex> get_user_by_google_account_id("1234")
      %User{}

      iex> get_user_by_google_account_id("1234")
      nil

  """
  def get_user_by_google_account_id(google_account_id) do
    Repo.get_by(User, google_account_id: google_account_id)
  end

  @doc """
  Gets a user by Cloudflare Access User ID.

  ## Examples

      iex> get_user_by_cloudflare_access_user_id("1234")
      %User{}

      iex> get_user_by_cloudflare_access_user_id("1234")
      nil

  """
  def get_user_by_cloudflare_access_user_id(cloudflare_access_user_id) do
    Repo.get_by(User, cloudflare_access_user_id: cloudflare_access_user_id)
  end

  @doc """
  Returns or registers a user by phone number.

  ## Examples

      iex> sync_user_by_phone_number("+601231113333")
      {:ok, %User{}}

  """
  def sync_user_by_phone_number(phone_number) do
    attrs = %{
      phone_numbers: [
        %{value: phone_number}
      ]
    }

    cast(%User{}, attrs, [])
    |> cast_assoc(:phone_numbers,
      required: true,
      with: &user_phone_number_changeset(&1, &2, on_conflict: :nothing)
    )
    |> Repo.insert!(on_conflict: :nothing)

    phone_number = Repo.get_by!(UserPhoneNumber, value: phone_number)

    {:ok, Repo.get!(User, phone_number.user_id)}
  end

  defp user_phone_number_changeset(phone_number, attrs, repo_opts) do
    cast(phone_number, attrs, [:value])
    |> validate_required([:value])
    |> string_trim(:value)
    |> unique_constraint(:value)
    |> Map.put(:repo_opts, repo_opts)
  end

  @doc """
  Returns or registers a user by Google account.

  ## Examples

      iex> sync_user_by_google_account("user@example.com", "djEi12Ge9kJH")
      {:ok, %User{}}

      iex> sync_user_by_google_account("user@example.com", "djEi12Ge9kJH")
      {:error, :invalid_google_account}

  """
  def sync_user_by_google_account(email_address, google_account_id) do
    user =
      get_user_by_email_address(email_address) ||
        get_user_by_google_account_id(google_account_id)

    case user do
      nil ->
        attrs = %{
          google_account_id: google_account_id,
          email_addresses: [
            %{value: email_address}
          ]
        }

        user =
          cast(%User{}, attrs, [:google_account_id])
          |> cast_assoc(:email_addresses,
            required: true,
            with: &user_email_address_changeset(&1, &2, [])
          )
          |> unique_constraint(:google_account_id)
          |> Repo.insert!()

        {:ok, user}

      %User{google_account_id: ^google_account_id} = user ->
        {:ok, user}

      _other ->
        {:error, :invalid_google_account}
    end
  end

  @doc """
  Returns or registers a user using Cloudflare Access User ID.

  ## Examples

      iex> sync_user_by_cloudflare_access("user@example.com", "cf_access_1234")
      {:ok, %User{}}

      iex> sync_user_by_cloudflare_access("user@example.com", "cf_access_1234")
      {:error, :email_address_not_allowed}

  """
  def sync_user_by_cloudflare_access(email_address, cloudflare_access_user_id) do
    with :ok <- nomdoc_email_address_only(email_address) do
      user =
        get_user_by_email_address(email_address) ||
          get_user_by_cloudflare_access_user_id(cloudflare_access_user_id)

      case user do
        nil ->
          attrs = %{
            cloudflare_access_user_id: cloudflare_access_user_id,
            email_addresses: [
              %{value: email_address}
            ]
          }

          user =
            cast(%User{}, attrs, [:cloudflare_access_user_id])
            |> cast_assoc(:email_addresses,
              required: true,
              with: &user_email_address_changeset(&1, &2, [])
            )
            |> unique_constraint(:cloudflare_access_user_id)
            |> Repo.insert!()

          {:ok, user}

        %User{cloudflare_access_user_id: ^cloudflare_access_user_id} = user ->
          {:ok, user}

        %User{cloudflare_access_user_id: nil} ->
          user =
            change(user, cloudflare_access_user_id: cloudflare_access_user_id)
            |> unique_constraint(:cloudflare_access_user_id)
            |> Repo.update!()

          {:ok, user}
      end
    end
  end

  defp nomdoc_email_address_only(email_address) do
    if String.ends_with?(email_address, "@nomdoc.com"),
      do: :ok,
      else: {:error, :email_address_not_allowed}
  end

  defp user_email_address_changeset(email_address, attrs, repo_opts) do
    # Don't need to validate email address format, regex, MX records since it's
    # coming from Google for now.
    cast(email_address, attrs, [:value])
    |> validate_required([:value])
    |> string_downcase(:value)
    |> string_trim(:value)
    |> unique_constraint(:email_address)
    |> Map.put(:repo_opts, repo_opts)
  end

  @doc """
  Generates a session token.
  """
  def generate_user_session_token(%User{} = user, context) do
    {token, user_token} = build_session_token(user, context)

    Repo.insert!(user_token)

    token
  end

  def build_session_token(user, context) do
    token =
      Uniq.UUID.uuid4()
      |> Base.url_encode64(padding: false)

    {token, %UserToken{token: token, context: "session:#{context}", user_id: user.id}}
  end

  @doc """
  Gets the user with the given signed token.
  """
  def get_user_by_session_token(token, context) do
    {:ok, query} = verify_session_token_query(token, context)

    Repo.one(query)
  end

  def verify_session_token_query(token, context) do
    query =
      from token in user_token_by_token_and_context_query(token, "session:#{context}"),
        join: user in assoc(token, :user),
        where: token.inserted_at > ago(@session_validity_in_days, "day"),
        select: user

    {:ok, query}
  end

  @doc """
  Deletes the signed token with the given context.
  """
  def delete_user_session_token(token, context) do
    user_token_by_token_and_context_query(token, "session:#{context}")
    |> Repo.delete_all()

    :ok
  end

  defp user_token_by_token_and_context_query(token, context) do
    from UserToken, where: [token: ^token, context: ^context]
  end
end
