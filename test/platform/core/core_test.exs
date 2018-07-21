# defmodule Platform.CoreTest do
#   use Platform.DataCase

#   alias Platform.Core

#   describe "currencies" do
#     alias Platform.Core.Schema.Currency

#     @valid_attrs %{volume_24h_usd: 120.5, available_supply: 120.5, market_cap_usd: 120.5, name: "some name", percent_change_1h: 120.5, percent_change_24h: 120.5, price_btc: 120.5, price_usd: 120.5, symbol: "some symbol", total_supply: 120.5, watch: true}
#     @update_attrs %{volume_24h_usd: 456.7, available_supply: 456.7, market_cap_usd: 456.7, name: "some updated name", percent_change_1h: 456.7, percent_change_24h: 456.7, price_btc: 456.7, price_usd: 456.7, symbol: "some updated symbol", total_supply: 456.7, watch: false}
#     @invalid_attrs %{volume_24h_usd: nil, available_supply: nil, market_cap_usd: nil, name: nil, percent_change_1h: nil, percent_change_24h: nil, price_btc: nil, price_usd: nil, symbol: nil, total_supply: nil, watch: nil}

#     def currency_fixture(attrs \\ %{}) do
#       {:ok, currency} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Core.create_currency()

#       currency
#     end

#     test "list_currencies/0 returns all currencies" do
#       currency = currency_fixture()
#       assert Core.list_currencies() == [currency]
#     end

#     test "get_currency!/1 returns the currency with given id" do
#       currency = currency_fixture()
#       assert Core.get_currency!(currency.id) == currency
#     end

#     test "create_currency/1 with valid data creates a currency" do
#       assert {:ok, %Currency{} = currency} = Core.create_currency(@valid_attrs)
#       assert currency.volume_24h_usd == 120.5
#       assert currency.available_supply == 120.5
#       assert currency.market_cap_usd == 120.5
#       assert currency.name == "some name"
#       assert currency.percent_change_1h == 120.5
#       assert currency.percent_change_24h == 120.5
#       assert currency.price_btc == 120.5
#       assert currency.price_usd == 120.5
#       assert currency.symbol == "some symbol"
#       assert currency.total_supply == 120.5
#       assert currency.watch == true
#     end

#     test "create_currency/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Core.create_currency(@invalid_attrs)
#     end

#     test "update_currency/2 with valid data updates the currency" do
#       currency = currency_fixture()
#       assert {:ok, currency} = Core.update_currency(currency, @update_attrs)
#       assert %Currency{} = currency
#       assert currency.volume_24h_usd == 456.7
#       assert currency.available_supply == 456.7
#       assert currency.market_cap_usd == 456.7
#       assert currency.name == "some updated name"
#       assert currency.percent_change_1h == 456.7
#       assert currency.percent_change_24h == 456.7
#       assert currency.price_btc == 456.7
#       assert currency.price_usd == 456.7
#       assert currency.symbol == "some updated symbol"
#       assert currency.total_supply == 456.7
#       assert currency.watch == false
#     end

#     test "update_currency/2 with invalid data returns error changeset" do
#       currency = currency_fixture()
#       assert {:error, %Ecto.Changeset{}} = Core.update_currency(currency, @invalid_attrs)
#       assert currency == Core.get_currency!(currency.id)
#     end

#     test "delete_currency/1 deletes the currency" do
#       currency = currency_fixture()
#       assert {:ok, %Currency{}} = Core.delete_currency(currency)
#       assert_raise Ecto.NoResultsError, fn -> Core.get_currency!(currency.id) end
#     end

#     test "change_currency/1 returns a currency changeset" do
#       currency = currency_fixture()
#       assert %Ecto.Changeset{} = Core.change_currency(currency)
#     end
#   end

#   describe "currency_comments" do
#     alias Platform.Core.CurrencyComment

#     @valid_attrs %{body: "some body", currency_id: 42, user_id: 42}
#     @update_attrs %{body: "some updated body", currency_id: 43, user_id: 43}
#     @invalid_attrs %{body: nil, currency_id: nil, user_id: nil}

#     def currency_comment_fixture(attrs \\ %{}) do
#       {:ok, currency_comment} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Core.create_currency_comment()

#       currency_comment
#     end

#     test "list_currency_comments/0 returns all currency_comments" do
#       currency_comment = currency_comment_fixture()
#       assert Core.list_currency_comments() == [currency_comment]
#     end

#     test "get_currency_comment!/1 returns the currency_comment with given id" do
#       currency_comment = currency_comment_fixture()
#       assert Core.get_currency_comment!(currency_comment.id) == currency_comment
#     end

#     test "create_currency_comment/1 with valid data creates a currency_comment" do
#       assert {:ok, %CurrencyComment{} = currency_comment} = Core.create_currency_comment(@valid_attrs)
#       assert currency_comment.body == "some body"
#       assert currency_comment.currency_id == 42
#       assert currency_comment.user_id == 42
#     end

#     test "create_currency_comment/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Core.create_currency_comment(@invalid_attrs)
#     end

#     test "update_currency_comment/2 with valid data updates the currency_comment" do
#       currency_comment = currency_comment_fixture()
#       assert {:ok, currency_comment} = Core.update_currency_comment(currency_comment, @update_attrs)
#       assert %CurrencyComment{} = currency_comment
#       assert currency_comment.body == "some updated body"
#       assert currency_comment.currency_id == 43
#       assert currency_comment.user_id == 43
#     end

#     test "update_currency_comment/2 with invalid data returns error changeset" do
#       currency_comment = currency_comment_fixture()
#       assert {:error, %Ecto.Changeset{}} = Core.update_currency_comment(currency_comment, @invalid_attrs)
#       assert currency_comment == Core.get_currency_comment!(currency_comment.id)
#     end

#     test "delete_currency_comment/1 deletes the currency_comment" do
#       currency_comment = currency_comment_fixture()
#       assert {:ok, %CurrencyComment{}} = Core.delete_currency_comment(currency_comment)
#       assert_raise Ecto.NoResultsError, fn -> Core.get_currency_comment!(currency_comment.id) end
#     end

#     test "change_currency_comment/1 returns a currency_comment changeset" do
#       currency_comment = currency_comment_fixture()
#       assert %Ecto.Changeset{} = Core.change_currency_comment(currency_comment)
#     end
#   end

#   describe "twitter_accounts" do
#     alias Platform.Social.Schema.TwitterAccount

#     @valid_attrs %{currency_id: 42, followers_count: 42, image_url: "some image_url", name: "some name", tweets_count: 42}
#     @update_attrs %{currency_id: 43, followers_count: 43, image_url: "some updated image_url", name: "some updated name", tweets_count: 43}
#     @invalid_attrs %{currency_id: nil, followers_count: nil, image_url: nil, name: nil, tweets_count: nil}

#     def twitter_account_fixture(attrs \\ %{}) do
#       {:ok, twitter_account} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Core.create_twitter_account()

#       twitter_account
#     end

#     test "list_twitter_accounts/0 returns all twitter_accounts" do
#       twitter_account = twitter_account_fixture()
#       assert Core.list_twitter_accounts() == [twitter_account]
#     end

#     test "get_twitter_account!/1 returns the twitter_account with given id" do
#       twitter_account = twitter_account_fixture()
#       assert Core.get_twitter_account!(twitter_account.id) == twitter_account
#     end

#     test "create_twitter_account/1 with valid data creates a twitter_account" do
#       assert {:ok, %TwitterAccount{} = twitter_account} = Core.create_twitter_account(@valid_attrs)
#       assert twitter_account.currency_id == 42
#       assert twitter_account.followers_count == 42
#       assert twitter_account.image_url == "some image_url"
#       assert twitter_account.name == "some name"
#       assert twitter_account.tweets_count == 42
#     end

#     test "create_twitter_account/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Core.create_twitter_account(@invalid_attrs)
#     end

#     test "update_twitter_account/2 with valid data updates the twitter_account" do
#       twitter_account = twitter_account_fixture()
#       assert {:ok, twitter_account} = Core.update_twitter_account(twitter_account, @update_attrs)
#       assert %TwitterAccount{} = twitter_account
#       assert twitter_account.currency_id == 43
#       assert twitter_account.followers_count == 43
#       assert twitter_account.image_url == "some updated image_url"
#       assert twitter_account.name == "some updated name"
#       assert twitter_account.tweets_count == 43
#     end

#     test "update_twitter_account/2 with invalid data returns error changeset" do
#       twitter_account = twitter_account_fixture()
#       assert {:error, %Ecto.Changeset{}} = Core.update_twitter_account(twitter_account, @invalid_attrs)
#       assert twitter_account == Core.get_twitter_account!(twitter_account.id)
#     end

#     test "delete_twitter_account/1 deletes the twitter_account" do
#       twitter_account = twitter_account_fixture()
#       assert {:ok, %TwitterAccount{}} = Core.delete_twitter_account(twitter_account)
#       assert_raise Ecto.NoResultsError, fn -> Core.get_twitter_account!(twitter_account.id) end
#     end

#     test "change_twitter_account/1 returns a twitter_account changeset" do
#       twitter_account = twitter_account_fixture()
#       assert %Ecto.Changeset{} = Core.change_twitter_account(twitter_account)
#     end
#   end

#   describe "posts" do
#     alias Platform.CMS.Schema.Post

#     @valid_attrs %{content_markdown: "some content_markdown", description: "some description", header_image: "some header_image", published_at: ~N[2010-04-17 14:00:00.000000], slug: "some slug", title: "some title"}
#     @update_attrs %{content_markdown: "some updated content_markdown", description: "some updated description", header_image: "some updated header_image", published_at: ~N[2011-05-18 15:01:01.000000], slug: "some updated slug", title: "some updated title"}
#     @invalid_attrs %{content_markdown: nil, description: nil, header_image: nil, published_at: nil, slug: nil, title: nil}

#     def post_fixture(attrs \\ %{}) do
#       {:ok, post} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Core.create_post()

#       post
#     end

#     test "list_posts/0 returns all posts" do
#       post = post_fixture()
#       assert Core.list_posts() == [post]
#     end

#     test "get_post!/1 returns the post with given id" do
#       post = post_fixture()
#       assert Core.get_post!(post.id) == post
#     end

#     test "create_post/1 with valid data creates a post" do
#       assert {:ok, %Post{} = post} = Core.create_post(@valid_attrs)
#       assert post.content_markdown == "some content_markdown"
#       assert post.description == "some description"
#       assert post.header_image == "some header_image"
#       assert post.published_at == ~N[2010-04-17 14:00:00.000000]
#       assert post.slug == "some slug"
#       assert post.title == "some title"
#     end

#     test "create_post/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Core.create_post(@invalid_attrs)
#     end

#     test "update_post/2 with valid data updates the post" do
#       post = post_fixture()
#       assert {:ok, post} = Core.update_post(post, @update_attrs)
#       assert %Post{} = post
#       assert post.content_markdown == "some updated content_markdown"
#       assert post.description == "some updated description"
#       assert post.header_image == "some updated header_image"
#       assert post.published_at == ~N[2011-05-18 15:01:01.000000]
#       assert post.slug == "some updated slug"
#       assert post.title == "some updated title"
#     end

#     test "update_post/2 with invalid data returns error changeset" do
#       post = post_fixture()
#       assert {:error, %Ecto.Changeset{}} = Core.update_post(post, @invalid_attrs)
#       assert post == Core.get_post!(post.id)
#     end

#     test "delete_post/1 deletes the post" do
#       post = post_fixture()
#       assert {:ok, %Post{}} = Core.delete_post(post)
#       assert_raise Ecto.NoResultsError, fn -> Core.get_post!(post.id) end
#     end

#     test "change_post/1 returns a post changeset" do
#       post = post_fixture()
#       assert %Ecto.Changeset{} = Core.change_post(post)
#     end
#   end

#   describe "currency_links" do
#     alias Platform.Core.Schema.CurrencyLink

#     @valid_attrs %{body: "some body", currency_id: 42, title: "some title", type: "some type", url: "some url", user_id: 42}
#     @update_attrs %{body: "some updated body", currency_id: 43, title: "some updated title", type: "some updated type", url: "some updated url", user_id: 43}
#     @invalid_attrs %{body: nil, currency_id: nil, title: nil, type: nil, url: nil, user_id: nil}

#     def currency_link_fixture(attrs \\ %{}) do
#       {:ok, currency_link} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Core.create_currency_link()

#       currency_link
#     end

#     test "get_currency_link!/1 returns the currency_link with given id" do
#       currency_link = currency_link_fixture()
#       assert Core.get_currency_link!(currency_link.id) == currency_link
#     end

#     test "create_currency_link/1 with valid data creates a currency_link" do
#       assert {:ok, %CurrencyLink{} = currency_link} = Core.create_currency_link(@valid_attrs)
#       assert currency_link.body == "some body"
#       assert currency_link.currency_id == 42
#       assert currency_link.title == "some title"
#       assert currency_link.type == "some type"
#       assert currency_link.url == "some url"
#       assert currency_link.user_id == 42
#     end

#     test "create_currency_link/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Core.create_currency_link(@invalid_attrs)
#     end

#     test "update_currency_link/2 with valid data updates the currency_link" do
#       currency_link = currency_link_fixture()
#       assert {:ok, currency_link} = Core.update_currency_link(currency_link, @update_attrs)
#       assert %CurrencyLink{} = currency_link
#       assert currency_link.body == "some updated body"
#       assert currency_link.currency_id == 43
#       assert currency_link.title == "some updated title"
#       assert currency_link.type == "some updated type"
#       assert currency_link.url == "some updated url"
#       assert currency_link.user_id == 43
#     end

#     test "update_currency_link/2 with invalid data returns error changeset" do
#       currency_link = currency_link_fixture()
#       assert {:error, %Ecto.Changeset{}} = Core.update_currency_link(currency_link, @invalid_attrs)
#       assert currency_link == Core.get_currency_link!(currency_link.id)
#     end

#     test "delete_currency_link/1 deletes the currency_link" do
#       currency_link = currency_link_fixture()
#       assert {:ok, %CurrencyLink{}} = Core.delete_currency_link(currency_link)
#       assert_raise Ecto.NoResultsError, fn -> Core.get_currency_link!(currency_link.id) end
#     end

#     test "change_currency_link/1 returns a currency_link changeset" do
#       currency_link = currency_link_fixture()
#       assert %Ecto.Changeset{} = Core.change_currency_link(currency_link)
#     end
#   end

#   describe "exchanges" do
#     alias Platform.Exchanges.Schema.Exchange

#     @valid_attrs %{api_docs_url: "some api_docs_url", country: "some country", name: "some name", website_url: "some website_url"}
#     @update_attrs %{api_docs_url: "some updated api_docs_url", country: "some updated country", name: "some updated name", website_url: "some updated website_url"}
#     @invalid_attrs %{api_docs_url: nil, country: nil, name: nil, website_url: nil}

#     def exchange_fixture(attrs \\ %{}) do
#       {:ok, exchange} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Core.create_exchange()

#       exchange
#     end

#     test "list_exchanges/0 returns all exchanges" do
#       exchange = exchange_fixture()
#       assert Core.list_exchanges() == [exchange]
#     end

#     test "get_exchange!/1 returns the exchange with given id" do
#       exchange = exchange_fixture()
#       assert Core.get_exchange!(exchange.id) == exchange
#     end

#     test "create_exchange/1 with valid data creates a exchange" do
#       assert {:ok, %Exchange{} = exchange} = Core.create_exchange(@valid_attrs)
#       assert exchange.api_docs_url == "some api_docs_url"
#       assert exchange.country == "some country"
#       assert exchange.name == "some name"
#       assert exchange.website_url == "some website_url"
#     end

#     test "create_exchange/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Core.create_exchange(@invalid_attrs)
#     end

#     test "update_exchange/2 with valid data updates the exchange" do
#       exchange = exchange_fixture()
#       assert {:ok, exchange} = Core.update_exchange(exchange, @update_attrs)
#       assert %Exchange{} = exchange
#       assert exchange.api_docs_url == "some updated api_docs_url"
#       assert exchange.country == "some updated country"
#       assert exchange.name == "some updated name"
#       assert exchange.website_url == "some updated website_url"
#     end

#     test "update_exchange/2 with invalid data returns error changeset" do
#       exchange = exchange_fixture()
#       assert {:error, %Ecto.Changeset{}} = Core.update_exchange(exchange, @invalid_attrs)
#       assert exchange == Core.get_exchange!(exchange.id)
#     end

#     test "delete_exchange/1 deletes the exchange" do
#       exchange = exchange_fixture()
#       assert {:ok, %Exchange{}} = Core.delete_exchange(exchange)
#       assert_raise Ecto.NoResultsError, fn -> Core.get_exchange!(exchange.id) end
#     end

#     test "change_exchange/1 returns a exchange changeset" do
#       exchange = exchange_fixture()
#       assert %Ecto.Changeset{} = Core.change_exchange(exchange)
#     end
#   end

#   describe "exchange_currencies" do
#     alias Platform.Exchanges.Schema.ExchangeCurrency

#     @valid_attrs %{active: true, currency_id: "some currency_id", symbol: "some symbol"}
#     @update_attrs %{active: false, currency_id: "some updated currency_id", symbol: "some updated symbol"}
#     @invalid_attrs %{active: nil, currency_id: nil, symbol: nil}

#     def exchange_currency_fixture(attrs \\ %{}) do
#       {:ok, exchange_currency} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Core.create_exchange_currency()

#       exchange_currency
#     end

#     test "list_exchange_currencies/0 returns all exchange_currencies" do
#       exchange_currency = exchange_currency_fixture()
#       assert Core.list_exchange_currencies() == [exchange_currency]
#     end

#     test "get_exchange_currency!/1 returns the exchange_currency with given id" do
#       exchange_currency = exchange_currency_fixture()
#       assert Core.get_exchange_currency!(exchange_currency.id) == exchange_currency
#     end

#     test "create_exchange_currency/1 with valid data creates a exchange_currency" do
#       assert {:ok, %ExchangeCurrency{} = exchange_currency} = Core.create_exchange_currency(@valid_attrs)
#       assert exchange_currency.active == true
#       assert exchange_currency.currency_id == "some currency_id"
#       assert exchange_currency.symbol == "some symbol"
#     end

#     test "create_exchange_currency/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Core.create_exchange_currency(@invalid_attrs)
#     end

#     test "update_exchange_currency/2 with valid data updates the exchange_currency" do
#       exchange_currency = exchange_currency_fixture()
#       assert {:ok, exchange_currency} = Core.update_exchange_currency(exchange_currency, @update_attrs)
#       assert %ExchangeCurrency{} = exchange_currency
#       assert exchange_currency.active == false
#       assert exchange_currency.currency_id == "some updated currency_id"
#       assert exchange_currency.symbol == "some updated symbol"
#     end

#     test "update_exchange_currency/2 with invalid data returns error changeset" do
#       exchange_currency = exchange_currency_fixture()
#       assert {:error, %Ecto.Changeset{}} = Core.update_exchange_currency(exchange_currency, @invalid_attrs)
#       assert exchange_currency == Core.get_exchange_currency!(exchange_currency.id)
#     end

#     test "delete_exchange_currency/1 deletes the exchange_currency" do
#       exchange_currency = exchange_currency_fixture()
#       assert {:ok, %ExchangeCurrency{}} = Core.delete_exchange_currency(exchange_currency)
#       assert_raise Ecto.NoResultsError, fn -> Core.get_exchange_currency!(exchange_currency.id) end
#     end

#     test "change_exchange_currency/1 returns a exchange_currency changeset" do
#       exchange_currency = exchange_currency_fixture()
#       assert %Ecto.Changeset{} = Core.change_exchange_currency(exchange_currency)
#     end
#   end
# end
