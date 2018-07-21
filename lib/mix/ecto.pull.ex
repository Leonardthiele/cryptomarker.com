defmodule Mix.Tasks.Ecto.Pull do
  @moduledoc false

  use Mix.Task

  @dump_file "gs://symetics/cryptomarker_prod.gz"
  @sql_instance_name "mysql-beta"
  @prod_db_name "cryptomarker_prod"
  def run(_) do
    Mix.shell.info "Dump prod db to: #{@dump_file}"
    Mix.shell.cmd("gcloud sql instances export #{@sql_instance_name} #{@dump_file} --database #{@prod_db_name} --quiet")
    Mix.shell.info "Done dumping. Dump located in bucket: #{@dump_file}"

    dev = Application.get_env(:platform, Platform.Repo)
    Mix.shell.info "Import prod db from google bucket: #{@dump_file}"
    Mix.shell.cmd("gsutil cat #{@dump_file} | gunzip | sed 's/#{@prod_db_name}/#{dev[:database]}/' | mysql -h #{dev[:hostname]} -u #{dev[:username]}")
    Mix.shell.info "Done importing"
  end
end
