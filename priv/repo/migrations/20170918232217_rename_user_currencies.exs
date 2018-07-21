defmodule Platform.Repo.Migrations.RenameUserCurrencies do
  use Ecto.Migration

  def change do
    rename table(:user_currencies), to: table(:currency_ratings)
  end
end
