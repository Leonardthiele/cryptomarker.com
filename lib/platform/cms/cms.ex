defmodule Platform.CMS do
  @moduledoc """
  The Core context.
  """
  import Ecto.Query, warn: false

  alias Platform.Repo
  alias Platform.CMS.Schema.Post

  ### ################################################################### ###
  ### Post                                                                ###
  ### ################################################################### ###
  def list_posts do
    Post
    |> Repo.all
  end

  def get_post!(id) do
    Post
    |> Repo.get_by!(slug: id)
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
