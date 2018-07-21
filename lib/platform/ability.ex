defmodule Platform.Ability do
  @moduledoc """
  Defines all access rights for all models. White listing approach.
  """
  alias Platform.Accounts.Schema.{User, CurrencyRating}
  alias Platform.CMS.Schema.{Post}
  alias Platform.Core.Schema.{Candle, Currency}
  alias Platform.Exchanges.Schema.{Exchange}
  alias Platform.Social.Schema.{TwitterStatus}

  # Admin
  def can?(%User{admin: true}, _, _), do: true

  # Moderator
  def can?(%User{moderator: true}, _, %Currency{}), do: true

  # User (logged in)
  def can?(%User{id: id}, :update, %CurrencyRating{user_id: user_id}), do: (id == user_id)

  # Guests
  def can?(_, action, %Post{}) when action in [:index, :show], do: true
  def can?(_, action, %Currency{}) when action in [:index, :show], do: true
  def can?(_, action, %Exchange{}) when action in [:index, :show], do: true
  def can?(_, action, %Candle{}) when action in [:index, :new], do: true
  def can?(_, action, %TwitterStatus{}) when action in [:index, :show], do: true

  # Else
  def can?(_, _, _), do: false
end
