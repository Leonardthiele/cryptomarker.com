defmodule Platform.Accounts do
  @moduledoc """
  The Accounts context. Everything that belongs to a user.
  The user model itself and e.g. user favorites, settings, etc.
  """
  import Ecto.Query, warn: false

  alias Platform.Accounts.Schema.User
  alias Platform.Accounts.Schema.CurrencyRating
  alias Platform.Repo

  ### ################################################################### ###
  ### User                                                                ###
  ### ################################################################### ###
  def paginate_users(params) do
    User
    |> Repo.paginate(params)
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(currency_ratings: :currency)
  end

  def get_user_by_email(email) do
    User
    |> Repo.get_by(email: email)
    |> Repo.preload(currency_ratings: :currency)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  ### ################################################################### ###
  ### CurrencyRating                                                      ###
  ### ################################################################### ###
  def list_currency_ratings(%User{} = user) do
    user
    |> Ecto.assoc(:currency_ratings)
    |> Repo.all
    |> Repo.preload(:currency)
  end

  def get_currency_rating_by_user_and_currency(user_id, currency_id) do
    CurrencyRating
    |> Repo.get_by(currency_id: currency_id, user_id: user_id)
  end

  def delete_currency_rating(%CurrencyRating{} = currency_rating) do
    Repo.delete(currency_rating)
  end

  def get_or_build_currency_rating(%User{id: user_id}, currency_id) do
    case get_currency_rating_by_user_and_currency(user_id, currency_id) do
      nil  -> %CurrencyRating{user_id: user_id, currency_id: String.to_integer(currency_id)}
      currency_rating -> currency_rating
    end
  end

  def insert_or_update_currency_rating(%CurrencyRating{} = currency_rating, attrs \\ %{}) do
    currency_rating
    |> CurrencyRating.changeset(attrs)
    |> Repo.insert_or_update()
  end
end
