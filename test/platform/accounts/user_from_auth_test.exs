defmodule Platform.Accounts.UserFromAuthTest do
  use Platform.DataCase

  alias Platform.Accounts.UserFromAuth
  alias Ueberauth.Auth

  describe "#find_or_create" do
    test "github - creates a user when exists" do
      demo_user = Factory.insert(:user)

      auth = %Auth{
        provider: :github,
        uid: String.to_integer(demo_user.github_uid),
        info: %{
          name: demo_user.name,
          email: demo_user.email
        }
      }
      {:ok, user} = UserFromAuth.find_or_create(auth)

      assert user.name == demo_user.name
      assert user.email == demo_user.email
      assert user.github_uid == demo_user.github_uid
    end

    test "github - creates a user when NOT exists with nickname" do
      auth = %Auth{
        provider: :github,
        uid: 1123432,
        info: %{
          first_name: "",
          last_name: "",
          nickname: "Johnny",
          email: "john@example.com"
        }
      }
      {:ok, user} = UserFromAuth.find_or_create(auth)

      assert user.name == "Johnny"
      assert user.email == "john@example.com"
      assert user.github_uid == "1123432"
    end

    test "github - creates a user when NOT exists with first/last name" do
      auth = %Auth{
        provider: :github,
        uid: 1123432,
        info: %{
          first_name: "John",
          last_name: "Doe",
          email: "john@example.com"
        }
      }
      {:ok, user} = UserFromAuth.find_or_create(auth)

      assert user.name == "John Doe"
      assert user.email == "john@example.com"
      assert user.github_uid == "1123432"
    end
  end
end
