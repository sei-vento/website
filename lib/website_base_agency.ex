defmodule WebsiteBaseAgency do
  @moduledoc """
  Documentation for `WebsiteBaseAgency`.
  """

  use Fermo, %{
    base_url: Application.fetch_env!(:fermo, :base_url),
    i18n: [:it, :en],
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

        config = Enum.reduce(
          blog_posts(locale),
          config,
          fn blog_post, config ->
            path = page_path(blog_post, locale)
            page(
              config,
              "/templates/blog_post.html.slim",
              Fermo.Paths.path_to_target(path),
              %{page: blog_post,
                locale: locale,
                id: "blog_post-#{blog_post.id}"}
            )
          end
        )

        blog_index = blog_index(locale)
        blog_index_path = page_path(blog_index, locale)
        config = page(
          config,
          "/templates/blog_index.html.slim",
          Fermo.Paths.path_to_target(blog_index_path),
          %{page: blog_index(locale),
            locale: locale,
            id: "blog_index"}
        )

        contact_page = contact_page(locale)
        contact_page_path = page_path(contact_page, locale)
        _config = page(
          config,
          "/templates/contact_page.html.slim",
          Fermo.Paths.path_to_target(contact_page_path),
          %{page: contact_page(locale),
            locale: locale,
            id: "contact_page"}
        )

      end
    )

    {:ok, config}
  end
  
end
