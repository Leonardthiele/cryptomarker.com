defmodule Platform.Social.Scheduler do
  @moduledoc false
  use Quantum.Scheduler, otp_app: :platform

  alias Platform.Social.GithubRepoApi
  alias Platform.Social.RedditApi
  alias Platform.Social.TwitterStatusApi
  alias Platform.Social.TwitterAccountApi

  def init(_config) do
    Quantum.runtime_config(__MODULE__, @otp_app, [
      jobs: [
        {"@minutely", &GithubRepoApi.update_all/0},
        {"@minutely", &RedditApi.update_all/0},
        {"@minutely", &TwitterStatusApi.update_from_home_timeline/0},
        {"@minutely", &TwitterAccountApi.update_all/0}
      ]
    ])
  end
end
