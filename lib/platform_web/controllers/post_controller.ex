defmodule PlatformWeb.PostController do
  use PlatformWeb, :controller

  alias Platform.CMS
  alias Platform.CMS.Schema.Post

  def index(conn, _params) do
    Post |> authorize_action!(conn)

    posts = CMS.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    Post |> authorize_action!(conn)

    changeset = CMS.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    Post |> authorize_action!(conn)

    case CMS.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = id |> CMS.get_post! |> authorize_action!(conn)

    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = id |> CMS.get_post! |> authorize_action!(conn)

    changeset = CMS.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = id |> CMS.get_post! |> authorize_action!(conn)

    case CMS.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = id |> CMS.get_post! |> authorize_action!(conn)

    {:ok, _post} = CMS.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
