defmodule PlatformWeb.FeedbackControllerTest do
  use PlatformWeb.ConnCase

  describe "#index" do
    test "lists all resources", %{conn: conn} do
      conn = get conn, feedback_path(conn, :index)
      assert html_response(conn, 200) =~ "Feedback"
    end
  end
end
