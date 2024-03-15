defmodule Nomdoc.ChangesetHelpers do
  @moduledoc false

  import Ecto.Changeset

  alias Ecto.Changeset

  @doc """
  A changeset wrapper around `String.downcase/2`.
  """
  def string_downcase(%Changeset{} = changeset, field, opts \\ []) do
    mode = Keyword.get(opts, :mode) || :default

    update_change(changeset, field, fn value ->
      if is_binary(value),
        do: String.downcase(value, mode),
        else: value
    end)
  end

  @doc """
  A changeset wrapper around `String.trim/1`.
  """
  def string_trim(%Changeset{} = changeset, field) do
    update_change(changeset, field, fn value ->
      if is_binary(value),
        do: String.trim(value),
        else: value
    end)
  end
end
