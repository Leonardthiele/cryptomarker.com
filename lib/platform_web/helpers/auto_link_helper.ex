defmodule PlatformWeb.AutoLinkHelper do
  @moduledoc """
  Replaces text links with html links
  """
  @auto_link_re ~r{
    (?: ((?:ed2k|ftp|http|https|irc|mailto|news|gopher|nntp|telnet|webcal|xmpp|callto|feed|svn|urn|aim|rsync|tag|ssh|sftp|rtsp|afs|file):)// | www\. )
    [^\s<"]+
  }ix

  @doc """
  iex> AutoLinkHelper.auto_link("http://elixir-lang.org/")
  ~s(<a href="http://elixir-lang.org/" target="_blank">http://elixir-lang.org/</a>)
  """
  def auto_link(text) do
    Regex.replace @auto_link_re, text, fn href, _scheme ->
      ~s(<a href="#{href}" target="_blank">#{href}</a>)
    end
  end
end
