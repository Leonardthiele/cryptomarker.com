defmodule Mix.Tasks.Assets.Pull do
  @moduledoc false

  use Mix.Task

  def run(_) do
    public_dir = "priv/static"
    File.mkdir_p!(public_dir <> "/uploads/")
    Mix.shell.info("copy uploads from google cloud bucket...")
    Mix.shell.cmd("gsutil -m rsync -d -r gs://cryptomarker-prod/uploads/ #{public_dir}/uploads/")
  end
end
