defmodule NomdocProxy do
  @moduledoc false

  use MainProxy.Proxy

  @impl MainProxy.Proxy
  def backends do
    Application.fetch_env!(:nomdoc, NomdocProxy)[:backends]
  end
end
