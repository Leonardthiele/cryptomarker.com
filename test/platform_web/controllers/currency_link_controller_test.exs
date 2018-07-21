defmodule PlatformWeb.CurrencyLinkControllerTest do
  use PlatformWeb.ConnCase

  @create_attrs Factory.params_for(:currency_link)
  @update_attrs %{url: "https://www.google.de"}
  @invalid_attrs %{type: nil}

  setup :login_as_admin
  setup :create_currency

  describe "#new" do
    test "renders form", %{conn: conn, currency: currency} do
      conn = get conn, currency_currency_link_path(conn, :new, currency)
      assert html_response(conn, 200) =~ "New link"
    end
  end

  describe "#create" do
    test "redirects to show when data is valid", %{conn: orig_conn, currency: currency} do
      conn = post orig_conn, currency_currency_link_path(orig_conn, :create, currency), currency_link: @create_attrs

      assert %{id: _id} = redirected_params(conn)
      assert redirected_to(conn) == currency_path(conn, :show, currency)

      conn = get orig_conn, currency_path(conn, :show, currency)
      assert html_response(conn, 200) =~ @create_attrs.url
    end

    test "renders errors when data is invalid", %{conn: conn, currency: currency} do
      conn = post conn, currency_currency_link_path(conn, :create, currency), currency_link: @invalid_attrs
      assert html_response(conn, 200) =~ "New link"
    end
  end

  describe "#edit" do
    setup :create_currency_link

    test "renders form for editing chosen currency_link", %{conn: conn, currency: currency, currency_link: currency_link} do
      conn = get conn, currency_currency_link_path(conn, :edit, currency, currency_link)
      assert html_response(conn, 200) =~ "Edit link"
    end
  end

  describe "#update" do
    setup :create_currency_link

    test "redirects when data is valid", %{conn: orig_conn, currency: currency, currency_link: currency_link} do
      conn = put orig_conn, currency_currency_link_path(orig_conn, :update, currency, currency_link), currency_link: @update_attrs
      assert redirected_to(conn) == currency_path(conn, :show, currency)

      conn = get orig_conn, currency_path(orig_conn, :show, currency)
      assert html_response(conn, 200) =~ @update_attrs.url
    end

    test "renders errors when data is invalid", %{conn: conn, currency: currency, currency_link: currency_link} do
      conn = put conn, currency_currency_link_path(conn, :update, currency, currency_link), currency_link: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit link"
    end
  end

  describe "#delete" do
    setup :create_currency_link

    test "deletes chosen currency_link", %{conn: orig_conn, currency: currency, currency_link: currency_link} do
      conn = delete orig_conn, currency_currency_link_path(orig_conn, :delete, currency, currency_link)
      assert redirected_to(conn) == currency_path(conn, :show, currency)

      conn = get orig_conn, currency_path(orig_conn, :show, currency)
      refute html_response(conn, 200) =~ currency_link.url
    end
  end

  # Private functions
  defp create_currency(_) do
    currency = Factory.insert(:currency)
    {:ok, currency: currency}
  end

  defp create_currency_link(%{currency: currency}) do
    currency_link = Factory.insert(:currency_link, currency: currency)
    {:ok, currency_link: currency_link}
  end
end
