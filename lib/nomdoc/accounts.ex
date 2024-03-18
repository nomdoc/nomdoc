defmodule Nomdoc.Accounts do
  @moduledoc false

  import Ecto.Changeset
  import Ecto.Query
  import Nomdoc.ChangesetHelpers

  alias Nomdoc.Accounts.User
  alias Nomdoc.Accounts.UserToken
  alias Nomdoc.Repo

  @session_validity_in_days 60

  @doc """
  Gets a user by Google Account ID and email address.

  ## Examples

      iex> get_user_by_google("1234")
      %User{}

      iex> get_user_by_google("1234")
      nil

  """
  def get_user_by_google_account_id(google_account_id) do
    Repo.get_by(User, google_account_id: google_account_id)
  end

  @doc """
  Registers a user.

  ## Examples

      iex> register_user(%{field: value})
      {:ok, %User{}}

      iex> register_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_user(attrs) do
    registration_changeset(%User{}, attrs, validate_email_address: true)
    |> Repo.insert()
  end

  defp registration_changeset(user, attrs, opts) do
    user
    |> cast(attrs, [:email_address, :google_account_id])
    |> validate_email_address(opts)
    |> validate_google_account_id()
  end

  defp validate_email_address(changeset, opts) do
    # Don't need to validate email address format, regex, MX records since it's
    # coming from Google for now.
    changeset
    |> validate_required([:email_address])
    |> string_downcase(:email_address)
    |> string_trim(:email_address)
    |> maybe_validate_unique_email_address(opts)
  end

  defp maybe_validate_unique_email_address(changeset, opts) do
    if Keyword.get(opts, :validate_email_address, true) do
      changeset
      |> unsafe_validate_unique(:email_address, Nomdoc.Repo)
      |> unique_constraint(:email_address)
    else
      changeset
    end
  end

  defp validate_google_account_id(changeset) do
    changeset
    |> validate_required([:google_account_id])
    |> unsafe_validate_unique(:google_account_id, Repo)
    |> unique_constraint(:google_account_id)
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
