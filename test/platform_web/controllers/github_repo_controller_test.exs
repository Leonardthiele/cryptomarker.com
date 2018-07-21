defmodule PlatformWeb.GithubRepoControllerTest do
  use PlatformWeb.ConnCase

  @create_attrs Factory.params_for(:github_repo)
  @invalid_attrs %{full_name: nil}

  setup :login_as_admin
  setup :create_currency

  describe "#new" do
    test "renders form", %{conn: conn, currency: currency} do
      conn = get conn, currency_github_repo_path(conn, :new, currency)
      assert html_response(conn, 200) =~ "New github repo"
    end
  end

  describe "#create" do
    test "redirects to show when data is valid", %{conn: orig_conn, currency: currency} do
      conn = post orig_conn, currency_github_repo_path(orig_conn, :create, currency), github_repo: @create_attrs

      assert %{id: _id} = redirected_params(conn)
      assert redirected_to(conn) == currency_path(conn, :show, currency)

      conn = get orig_conn, currency_path(conn, :show, currency)
      assert html_response(conn, 200) =~ @create_attrs.full_name
    end

    test "renders errors when data is invalid", %{conn: conn, currency: currency} do
      conn = post conn, currency_github_repo_path(conn, :create, currency), github_repo: @invalid_attrs
      assert html_response(conn, 200) =~ "New github repo"
    end
  end

  describe "#delete" do
    setup :create_github_repo

    test "deletes chosen github_repo", %{conn: orig_conn, currency: currency, github_repo: github_repo} do
      conn = delete orig_conn, currency_github_repo_path(orig_conn, :delete, currency, github_repo)
      assert redirected_to(conn) == currency_path(conn, :show, currency)

      conn = get orig_conn, currency_path(orig_conn, :show, currency)
      refute html_response(conn, 200) =~ github_repo.full_name
    end
  end

  # Private functions
  defp create_currency(_) do
    currency = Factory.insert(:currency)
    {:ok, currency: currency}
  end

  defp create_github_repo(%{currency: currency}) do
    github_repo = Factory.insert(:github_repo, currency: currency)
    {:ok, github_repo: github_repo}
  end
end
