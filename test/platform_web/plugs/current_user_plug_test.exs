defmodule PlatformWeb.CurrentUserPlugTest do
  alias PlatformWeb.CurrentUserPlug
  use PlatformWeb.ConnCase

  describe "#init" do
    test "passes the options unmodified" do
      opts = %{test: 123}
      assert CurrentUserPlug.init(opts) == opts
    end
  end

  describe "#call" do
    test "blub" do

    end
  end
end
