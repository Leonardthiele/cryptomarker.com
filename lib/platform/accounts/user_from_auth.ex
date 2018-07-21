defmodule Platform.Accounts.UserFromAuth do
  @moduledoc """
  Retrieve the user information from an auth request
  """
  alias Ueberauth.Auth
  alias Platform.Accounts

  def find_or_create(%Auth{provider: :github} = auth) do
    info = basic_info(auth)

    changes = %{
       github_uid: Integer.to_string(info.id),
       email: info.email,
       name: info.name
    }

    model = case Accounts.get_user_by_email(info.email) do
      nil  -> Accounts.create_user(changes)
      user -> {:ok, user}
    end

    model
  end

  # Private functions
  defp basic_info(auth) do
    %{id: auth.uid, name: name_from_auth(auth), email: auth.info.email}
  end

  defp name_from_auth(%Auth{info: %{name: name}}), do: name
  defp name_from_auth(%Auth{info: info}) do
    name = String.trim("#{info.first_name} #{info.last_name}")

    if String.length(name) > 0 do
      name
    else
      info.nickname
    end
  end
end
