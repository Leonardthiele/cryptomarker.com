defmodule Platform.Repo.Migrations.DropExchangeApis do
  use Ecto.Migration

  def change do
    drop table(:exchange_apis)
  end
end
