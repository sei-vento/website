defmodule Vento do
  @moduledoc """
  Documentation for `Vento`.
  """

  use Fermo, %{
    base_url: Application.fetch_env!(:fermo, :base_url),
    i18n: [:en],
    path_map: true,
    exclude: ["templates/*", "layouts/*", "javascripts/*", "stylesheets/*"]
  }
  import Fermo, only: [page: 4]

  use Helpers

  def config do
    config = initial_config()
    {:ok} = Fermo.I18n.load()
    DatoCMS.GraphQLClient.configure()
  
    config = Fermo.Config.add_static(config, "netlify.toml", "netlify.toml")
    config = Fermo.Config.add_static(config, "site.webmanifest", "site.webmanifest")
    config = Fermo.Config.add_static(config, "browserconfig.xml", "browserconfig.xml")

    config = page(
      config,
      "/templates/404.html.slim",
      "/404.html",
      %{locale: :it,
        id: "error_page"}
    )

    config = Enum.reduce(
      config.i18n,
      config,
      fn (locale, config) ->
        home_path = "#{locale_url_prefix(locale)}index.html"
        config = page(
          config,
          "/templates/homepage.html.slim",
          home_path,
          %{page: home_page(locale),
            locale: locale,
            id: "home_page"}
        )

        program_page = program_page(locale)
        program_page_path = page_path(program_page, locale)
        config = page(
          config,
          "/templates/program_page.html.slim",
          Fermo.Paths.path_to_target(program_page_path),
          %{page: program_page(locale),
            locale: locale,
            id: "program_page"}
        )

        application_page = application_page(locale)
        application_page_path = page_path(application_page, locale)
        config = page(
          config,
          "/templates/application_page.html.slim",
          Fermo.Paths.path_to_target(application_page_path),
          %{page: application_page(locale),
            locale: locale,
            id: "application_page"}
        )

        walf_page = walf_page(locale)
        walf_page_path = page_path(walf_page, locale)
        config = page(
          config,
          "/templates/walf_page.html.slim",
          Fermo.Paths.path_to_target(walf_page_path),
          %{page: walf_page(locale),
            locale: locale,
            id: "walf_page"}
        )

        about_page = about_page(locale)
        about_page_path = page_path(about_page, locale)
        config = page(
          config,
          "/templates/about_page.html.slim",
          Fermo.Paths.path_to_target(about_page_path),
          %{page: about_page(locale),
            locale: locale,
            id: "about_page"}
        )

        network_page = network_page(locale)
        network_page_path = page_path(network_page, locale)
        config = page(
          config,
          "/templates/network_page.html.slim",
          Fermo.Paths.path_to_target(network_page_path),
          %{page: network_page(locale),
            locale: locale,
            id: "network_page"}
        )

        faq_page = faq_page(locale)
        faq_page_path = page_path(faq_page, locale)
        config = page(
          config,
          "/templates/faq_page.html.slim",
          Fermo.Paths.path_to_target(faq_page_path),
          %{page: faq_page(locale),
            locale: locale,
            id: "faq_page"}
        )

      end
    )

    {:ok, config}
  end
  
end