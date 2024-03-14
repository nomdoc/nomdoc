defmodule Nomdoc.GoogleOAuth.GoogleAccount do
  @moduledoc false

  use TypedStruct

  typedstruct do
    field :id, binary(), enforce: true
    field :name, binary(), enforce: true
    field :email_address, binary(), enforce: true
    field :picture, binary(), enforce: true
  end

  def build(claims) do
    %__MODULE__{
      id: get_id(claims),
      name: get_name(claims),
      email_address: get_email_address(claims),
      picture: get_picture(claims)
    }
  end

  defp get_id(claims) do
    (claims["sub"] || raise(RuntimeError, message: "Google ID token missing 'sub' claim"))
    |> String.trim()
  end

  defp get_name(claims) do
    (claims["name"] || raise(RuntimeError, message: "Google ID token missing 'name' claim"))
    |> String.trim()
  end

  defp get_email_address(claims) do
    (claims["email"] || raise(RuntimeError, message: "Google ID token missing 'email' claim"))
    |> String.trim()
    |> String.downcase()
  end

  defp get_picture(claims) do
    (claims["picture"] || raise(RuntimeError, message: "Google ID token missing 'picture' claim"))
    |> String.trim()
  end
end
