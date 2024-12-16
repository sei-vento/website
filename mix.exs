defmodule Vento.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :vento,
      version: "0.1.0",
      elixir: "~> 1.15",
      compilers: Mix.compilers() ++ [:fermo],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:datocms_graphql_client, ">= 0.0.0"},
      {:fermo_datocms_graphql_client, ">= 0.0.0"},
      {:fermo_helpers, ">= 0.0.0"},
      {:fermo, "0.16.1"},
      {:memoize, ">= 0.0.0"},
      {:slime, github: "populimited/slime", ref: "no-compile", override: true}
    ]
  end
end
