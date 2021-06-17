defmodule WebsiteBaseAgency.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :website_base_agency,
      version: "0.1.0",
      elixir: "~> 1.9",
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
      {:fermo, "0.14.3"}  ,
  {:datocms_graphql_client, "~> 0.14.3"},
  {:fermo_datocms_graphql_client, "~> 0.14.3"}

    ]
  end
end
