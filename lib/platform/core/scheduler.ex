defmodule Platform.Core.Scheduler do
  @moduledoc false
  use Quantum.Scheduler, otp_app: :platform

  alias Platform.Core.CurrencyUpdaterCmc

  def init(_config) do
    Quantum.runtime_config(__MODULE__, @otp_app, [
      jobs: [
        {{:extended, "*/15"}, &CurrencyUpdaterCmc.update_all/0}
      ]
    ])
  end
end
