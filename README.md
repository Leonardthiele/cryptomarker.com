# cryptomarker.com

## Prepare the development environment:

  * Install dependencies with `mix deps.get`
  * Start MySQL witch `mysql.server start`
  * Create and setup the database with `mix ecto.create && mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`

## Assets from Google Cloud

  * Install google cloud sdk with `brew cask install google-cloud-sdk`
  * Authenticate with `gcloud auth login`
  * Pull the production database with `mix ecto.pull`
  * Pull the images with `mix assets.pull`

## Starting the server

  * Start Phoenix endpoint with `mix s`
  * Visit [`localhost:4000`](http://localhost:4000) from your browser.

## Running tests

  * For a single run: `mix test`
  * For continous testing: `mix test.watch`
