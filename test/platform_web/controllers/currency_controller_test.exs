defmodule PlatformWeb.CurrencyControllerTest do
  use PlatformWeb.ConnCase

  @create_attrs Factory.params_for(:currency)
  @update_attrs %{name: "Ethereum"}
  @invalid_attrs %{name: ""}

  setup :login_as_admin

  describe "#index" do
    setup :create_currency

    test "lists all currencies", %{conn: conn, currency: currency} do
      conn = get conn, currency_path(conn, :index)
      assert html_response(conn, 200) =~ currency.name
    end
  end

  describe "new currency" do
    test "renders form", %{conn: conn} do
      conn = get conn, currency_path(conn, :new)
      assert html_response(conn, 200) =~ "New currency"
    end
  end

  describe "create currency" do
    test "redirects to show when data is valid", %{conn: orig_conn} do
      conn = post orig_conn, currency_path(orig_conn, :create), currency: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == currency_path(conn, :show, id)

      conn = get orig_conn, currency_path(orig_conn, :show, id)
      assert html_response(conn, 200) =~ @create_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, currency_path(conn, :create), currency: @invalid_attrs
      assert html_response(conn, 200) =~ "New currency"
    end
  end

  describe "edit currency" do
    setup :create_currency

    test "renders form for editing chosen currency", %{conn: conn, currency: currency} do
      conn = get conn, currency_path(conn, :edit, currency)
      assert html_response(conn, 200) =~ "Edit currency"
    end
  end

  describe "update currency" do
    setup :create_currency

    test "redirects when data is valid", %{conn: orig_conn, currency: currency} do
      conn = put orig_conn, currency_path(orig_conn, :update, currency), currency: @update_attrs
      assert redirected_to(conn) == currency_path(conn, :show, currency)

      conn = get orig_conn, currency_path(orig_conn, :show, currency)
      assert html_response(conn, 200) =~ @update_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn, currency: currency} do
      conn = put conn, currency_path(conn, :update, currency), currency: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit currency"
    end
  end

  describe "delete currency" do
    setup :create_currency

    test "deletes chosen currency", %{conn: orig_conn, currency: currency} do
      conn = delete orig_conn, currency_path(orig_conn, :delete, currency)
      assert redirected_to(conn) == currency_path(conn, :index)
      assert_error_sent 404, fn ->
        get orig_conn, currency_path(orig_conn, :show, currency)
      end
    end
  end

  # Private functions
  defp create_currency(_) do
    currency = Factory.insert(:currency)
    {:ok, currency: currency}
  end
end
