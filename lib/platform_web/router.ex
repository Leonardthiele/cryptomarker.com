defmodule PlatformWeb.Router do
  use PlatformWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PlatformWeb.CurrentUserPlug
  end

  pipeline :api do
    plug :accepts, ["csv"]
  end

  scope "/", PlatformWeb do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController, only: [:index, :show, :edit, :update] do
      resources "/currency_ratings", CurrencyRatingController, only: [:index, :create, :delete]
    end

    resources "/feedback", FeedbackController, only: [:index]
    resources "/twitter_statuses", TwitterStatusController, only: [:index, :show, :update]
    resources "/posts", PostController
    resources "/currencies", CurrencyController do
      resources "/candles", CandleController, only: [:index, :create]
      resources "/currency_links", CurrencyLinkController, except: [:index, :show]
      resources "/twitter_accounts", TwitterAccountController, only: [:index, :show, :new, :create, :delete]
      resources "/github_repos", GithubRepoController, only: [:new, :create, :delete]
      resources "/reddits", RedditController, only: [:new, :create, :delete]
    end
    resources "/exchanges", ExchangeController do
      resources "/exchange_currencies", ExchangeCurrencyController, except: [:index, :show]
    end

    get "/", PageController, :index
  end

  scope "/api", PlatformWeb.Api, as: :api do
    pipe_through :api
    resources "/currencies", CurrencyController, only: [:index]
    resources "/candles", CandleController, only: [:index]
    resources "/twitter_statuses", TwitterStatusController
  end

  scope "/developer", PlatformWeb.Developer, as: :developer do
    pipe_through [:browser]

    resources "/", DashboardController, only: [:show, :update], singleton: true
  end

  scope "/auth", PlatformWeb do
    pipe_through [:browser]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end
end
