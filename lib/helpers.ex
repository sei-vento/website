defmodule Helpers do
  @moduledoc false

  defmacro __using__(_opts \\ %{}) do
    quote do
      import I18n.Helpers
      import FermoHelpers.Links
      import Fermo.DatoCMS.GraphQLClient
      import DatoCMS.GraphQLClient.MetaTagHelpers
      import DatoCMS.GraphQLClient.ImageHelpers
      import DatoCMS.StructuredText
      import Enum
      import Vento.Paths
      def environment, do: System.get_env("BUILD_ENV")
      use Memoize

      @max_text 24
      @transform_to_hyphen ~r([‐' ’,&+.#/@!:°])u

      defmemo home_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            homePage(locale: $locale) {
              #{seo_meta_tags_fragment()}
              _modelApiKey
              _updatedAt
              id
              title
              menuLabel
              slug
              cta
              cta2
              imageHero {
                responsiveImage(sizes: "(min-width: 1024px) 45vw, 100vw",
                imgixParams: {auto: [compress,format], fit: crop, w: "1100", h: "1300"}) {
                  #{responsive_image_fragment()}
                }
                blurUpThumb
              }
              titleHero
              service {
                ... on ContactBlockRecord {
                  id
                  _modelApiKey
                  prefix
                  text
                  cta
                }
                ... on DateTitleSubtitleCtaDescriptionRecord {
                  id
                  _modelApiKey
                  date
                  title
                  subtitle
                  description
                  cta
                  internalOrExternal
                  link {
                    ... on ApplicationPageRecord {
                      id
                      slug
                      title
                    }
                    ... on ProgramPageRecord {
                      id
                      slug
                      title
                    }
                  }
                  externalLinkLabel
                  externalLinkUrl
                  widget {
                    id
                    icon {
                      url
                      alt
                    }
                    position
                    title
                    description
                  }
                }
                ... on PrefixTitleLinkImageRecord {
                  id
                  _modelApiKey
                  direction
                  image {
                    responsiveImage(sizes: "(min-width: 1024px) 50vw, 100vw",
                    imgixParams: {auto: [compress,format], fit: crop, w: "1055"}) {
                      #{responsive_image_fragment()}
                    }
                    blurUpThumb
                  }
                  prefix
                  title
                  link {
                    ... on AboutPageRecord {
                      id
                      slug
                    }
                    ... on NetworkPageRecord {
                      id
                      slug
                    }
                    ... on WalfPageRecord {
                      id
                      slug
                    }
                  }
                  cta
                }
                ... on InternalLinkRecord {
                  id
                  _modelApiKey
                  label
                  link {
                    ... on AboutPageRecord {
                      id
                      title
                      slug
                    }
                    ... on ContactPageRecord {
                      id
                      title
                      slug
                    }
                    ... on FaqPageRecord {
                      id
                      title
                      slug
                    }
                    ... on HomePageRecord {
                      id
                      title
                      slug
                    }
                    ... on InvestmentsProgramPageRecord {
                      id
                      title
                      slug
                    }
                    ... on InvestmentsSelectionProgramPageRecord {
                      id
                      title
                      slug
                    }
                    ... on NetworkPageRecord {
                      id
                      title
                      slug
                    }
                    ... on ProgramPageRecord {
                      id
                      title
                      slug
                    }
                    ... on WalfPageRecord {
                      id
                      title
                      slug
                    }
                  }
                }
                ... on PortfolioRecord {
                  id
                  title
                  description
                  _modelApiKey
                  image {
                    responsiveImage(sizes: "(min-width: 1024px) 25vw, 90vw",
                    imgixParams: {auto: [compress,format], fit: crop, w: "600"}) {
                      #{responsive_image_fragment()}
                    }
                  blurUpThumb
                }
                }
              }
            }
          }
          """, %{locale: locale})

        result[:homePage]
      end

      defmemo program_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            programPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              id
              title
              slug
              menuLabel
              titleHero
              body {
                ... on BigTitlePrefixImageTitleDescriptionRecord {
                  id
                  _modelApiKey
                  bigTitle
                  buttonApply
                  createdAt
                  description
                  title
                  when
                  where
                  image {
                    responsiveImage(sizes: "(min-width: 1600px) 50vw, 100vw",
                    imgixParams: {auto: [compress,format], fit: crop, w: "1055"}) {
                      #{responsive_image_fragment()}
                    }
                    blurUpThumb
                  }
                }
                ... on ContactBlockRecord {
                  id
                  _modelApiKey
                  cta
                  prefix
                  text
                }
              }
              bigTitleWhere
              titleWhere
              textWhere
              titleAddress
              address
              linkGoogleMaps
              coverVideo {
                responsiveImage(sizes: "(min-width: 1600px) 100vw, 100vw",
                imgixParams: {auto: [compress,format], fit: crop, w: "1055"}) {
                  #{responsive_image_fragment()}
                }
                blurUpThumb
              }
              offersTitle
              offersBlocks {
                _modelApiKey
                text
                title
              }
              video {
                video {
                  streamingUrl
                  thumbnailUrl
                  mp4Url
                }
              }
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:programPage]
      end

      defmemo application_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            applicationPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              title
              slug
              menuLabel
              id
              titleHero
              body {
                ... on BigTitlePrefixImageTitleDescriptionRecord {
                  id
                  _modelApiKey
                  bigTitle
                  buttonApply
                  createdAt
                  description
                  title
                  when
                  where
                  image {
                    responsiveImage(sizes: "(min-width: 1600px) 50vw, 100vw",
                    imgixParams: {auto: [compress,format], fit: crop, w: "1055"}) {
                      #{responsive_image_fragment()}
                    }
                    blurUpThumb
                  }
                }
                ... on ContactBlockRecord {
                  id
                  _modelApiKey
                  cta
                  prefix
                  text
                }
              }
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:applicationPage]
      end

      defmemo walf_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            walfPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              title
              id
              slug
              menuLabel
              imageHero {
                responsiveImage(sizes: "(min-width: 1024px) 60vw, 100vw",
                imgixParams: {auto: [compress,format], fit: crop, w: "1024"}) {
                  #{responsive_image_fragment()}
                }
                blurUpThumb
              }
              titleHero
              descriptionHero
              bodyTop {
                _modelApiKey
                id
                direction
                title
                description
                image {
                  responsiveImage(sizes: "(min-width: 1024px) 60vw, 100vw",
                  imgixParams: {auto: [compress,format], fit: crop, w: "1024"}) {
                    #{responsive_image_fragment()}
                  }
                  blurUpThumb
                }
              }
              bigTitleFounder
              titleFounder
              descriptionFounder
              bodyBottom {
                _modelApiKey
                id
                image {
                  responsiveImage(sizes: "(min-width: 1024px) 60vw, 100vw",
                  imgixParams: {auto: [compress,format], fit: crop, w: "1024"}) {
                    #{responsive_image_fragment()}
                  }
                  blurUpThumb
                }
                title
                description
              }
              textApply
              bodyFooter {
                _modelApiKey
                id
                cta
                prefix
                text
              }
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:walfPage]
      end

      defmemo about_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            aboutPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              id
              title
              slug
              menuLabel
              imageHero {
                responsiveImage(sizes: "(min-width: 1024px) 60vw, 100vw",
                imgixParams: {auto: [compress,format], fit: crop, w: "1024"}) {
                  #{responsive_image_fragment()}
                }
                blurUpThumb
              }
              titleHero
              blockManifesto {
                _modelApiKey
                id
                text
                title
              }
              titleManifesto
              blockAdvisor {
                _modelApiKey
                id
                link
                name
                role
                image {
                  responsiveImage(sizes: "(min-width: 1024px) 33vw, 90vw",
                  imgixParams: {auto: [compress,format], fit: crop, w: "800"}) {
                    #{responsive_image_fragment()}
                  }
                  blurUpThumb
                }
              }
              titleAdvisor
              blockTeam {
                _modelApiKey
                id
                link
                name
                role
                cta
                image {
                  responsiveImage(sizes: "(min-width: 1024px) 25vw, 90vw",
                  imgixParams: {auto: [compress,format], fit: crop, w: "800"}) {
                    #{responsive_image_fragment()}
                  }
                  blurUpThumb
                }
              }
              titleTeam
              programTitle
              programBlock {
                _modelApiKey
                id
                image {
                  url
                }
                numberText
                prefix
                when
                description
              }
              titleEco
              blockEco {
                _modelApiKey
                id
                image {
                  responsiveImage(sizes: "(min-width: 1024px) 33vw, 50vw",
                  imgixParams: {auto: [compress,format], fit: crop, w: "800"}) {
                    #{responsive_image_fragment()}
                  }
                  blurUpThumb
                }
              }
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:aboutPage]
      end

      defmemo network_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            networkPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              id
              title
              slug
              menuLabel
              imageHero {
                responsiveImage(sizes: "(min-width: 1024px) 60vw, 100vw",
                imgixParams: {auto: [compress,format], fit: crop, w: "1024"}) {
                  #{responsive_image_fragment()}
                }
                blurUpThumb
              }
              titleHero
              titleStake
              blockStake {
                _modelApiKey
                id
                image {
                  url
                }
                numberText
                prefix
                when
                description
              }
              programTitle
              programBlock {
                _modelApiKey
                id
                image {
                  url
                }
                numberText
                prefix
                when
                description
              }
              titleEco
              blockEco {
                _modelApiKey
                id
                image {
                  responsiveImage(sizes: "(min-width: 1024px) 33vw, 50vw",
                  imgixParams: {auto: [compress,format], fit: crop, w: "800"}) {
                    #{responsive_image_fragment()}
                  }
                  blurUpThumb
                }
              }
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:networkPage]
      end

      defmemo apply_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            applyPage(locale: $locale) {
              _modelApiKey
              id
              title
              slug
              menuLabel
              titleHero
              cta
              link
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:applyPage]
      end

      defmemo thanks_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            thanksPage(locale: $locale) {
              _modelApiKey
              id
              title
              slug
              messaggeSuccess
              menuLabel
              titleHero
              icon {
                url
                alt
              }
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:thanksPage]
      end

      defmemo faq_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            faqPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              id
              title
              slug
              menuLabel
              ctaApply
              titleApply
              prefixApply
              body {
                titleAccordion
                accordion {
                  _modelApiKey
                  id
                  question
                  answer
                }
              }
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:faqPage]
      end

      defmemo info(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            info(locale: $locale) {
              copyFooter
              email
              address
              emailForm
              phone {
                number
                label
              }
              social {
                link
                title
              }
              primaryColor {
                hex
              }
              secondaryColor {
                hex
              }
              tertiaryColor {
                hex
              }
              ball {
                responsiveImage(sizes: "(min-width: 600px) 50vw, 100vw",
                imgixParams: {auto: [compress,format], fit: crop, w: "960"}) {
                  #{responsive_image_fragment()}
                }
                blurUpThumb
              }
            }
          }
          """, %{locale: locale})

        result[:info]
      end

      defmemo investments_program_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            investmentsProgramPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              id
              title
              slug
              menuLabel
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:investmentsProgramPage]
      end

      defmemo investments_selection_program_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            investmentsSelectionProgramPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              id
              title
              slug
              menuLabel
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:investmentsSelectionProgramPage]
      end

      defmemo contact_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            contactPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              id
              title
              slug
              menuLabel
              #{seo_meta_tags_fragment()}
            }
          }
          """, %{locale: locale})

        result[:contactPage]
      end

      defmemo accordion(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            allAccordions(locale: $locale) {
              question
              answer
            }
          }
          """, %{locale: locale})

        result[:allAccordions]
      end

      def render_link_to_record(item, node) do
        [~s(<a href="/items/#{item.slug}">#{hd(node.children).value}</a>)]
      end

      def render_inline_record(article) do
        ["<strong>#{article.title}</strong>"]
      end

      def render_block(%{__typename: "ImageRecord"} = block) do
        [~s(<figure><img.img--cover src="#{block.image.url}"></figure>)]
      end

      def render_block(%{__typename: "AttachmentBlockRecord"} = block) do
        [~s(<div><h2>#{block.title}</h2><a class="button--primary" href="#{block.file.url}" download="download" ></div>)]
      end

      def render_heading(node, dast, options) do
        inner = Enum.flat_map(node.children, &(render(&1, dast, options)))
        if node.level == 2 do
          slug = slug(inner)
          [~s(<div class="anchor-offset"><span class="anchor-offset__target" id="#{slug}"></span><h2>#{inner}</h2></div>)]
        else
          tag = "h#{node.level}"
          ["<#{tag}>"] ++ inner ++ ["</#{tag}>"]
        end
      end

      def render_code(
        %{
          type: "span",
          marks: ["code" | _marks]
        } = node,
        dast,
        options
      ) do
        [~s(<pre><code class="language-plaintext">#{node.value}</code></pre>)]
      end

      def render_code(
        %{
          type: "code",
          code: code,
          language: language
        } = node,
        dast,
        options
      ) do
        [~s(<pre><code class="language-#{language}">#{code}</code></pre>)]
      end

      def render_code(
        %{
          type: "code",
          code: code,
        } = node,
        dast,
        options
      ) do
        [~s(<pre><code class="language-plaintext">#{code}</code></pre>)]
      end

      def structured_text_to_html(dast) do
        options = %{
          renderers: %{
            render_link_to_record: &render_link_to_record/2,
            render_inline_record: &render_inline_record/1,
            render_block: &render_block/1,
            render_heading: &render_heading/3,
            render_code: &render_code/3
          }
        }
        DatoCMS.StructuredText.to_html(dast, options)
      end

      def content_with_fallback(page) do
        if Map.has_key?(page, :content) && page.content != nil do
          structured_text_to_html(page.content)
        else
          ""
        end
      end

      def page_has_children?(page) do
        Map.has_key?(page, :children) && Enum.count(page.children) > 0
      end

      def page_has_parent?(page) do
        Map.has_key?(page, :parent) && page.parent != nil
      end

      def page_has_ancestor?(page, locale) do
        page_ancestor(page, locale) != ""
      end

      def page_ancestor(page, locale) do
        case page._modelApiKey do
          _ -> ""
        end
      end

      def ancestor_path(page, locale) do
        if page_has_ancestor?(page, locale) do
          "#{page_ancestor(page, locale).slug}/"
        else
          ""
        end
      end

      def page_parent(page) do
        if page_has_parent?(page) do
          page.parent
        else
          ""
        end
      end

      def page_path(page, locale) do
        if Map.has_key?(page, :slug) && page.slug != nil do
          ancestor_path = ancestor_path(page, locale)

          parent_path = if page_has_parent?(page),
            do: "#{page_parent(page).slug}/",
            else: ""

          full_path = "#{ancestor_path}#{parent_path}#{page.slug}"
          path_with_locale_prefix(full_path, locale)
        else
          locale_url_prefix(locale)
        end
      end

      def page_is_current?(page, current_page) do
        page.id == current_page.id
      end

      def page_is_child?(page, current_page) do
        if Map.has_key?(current_page, :parent) && current_page.parent != nil do
          current_page.parent.id == page.id
        end
      end

      def page_is_current_or_child?(page, current_page) do
        page_is_current?(page,current_page) || page_is_child?(page, current_page)
      end

      def nav_expanded_class(page, current_page) do
        if page_is_current_or_child?(page, current_page) do
          "is-open"
        end
      end

      def aria_expanded_status(page, current_page) do
        if page_is_current_or_child?(page, current_page) do
          "true"
        else
          "false"
        end
      end

      def nav_item_active_class(page, current_page) do
        if page_is_current_or_child?(page, current_page) do
          "is-active"
        end
      end

      def slug(title, options \\ []) do
        max_text = options[:max_text] || @max_text
        clean = :unicode.characters_to_nfd_binary(title)
        |> String.replace(@transform_to_hyphen, "-")
        |> String.replace("ø", "o")
        |> String.replace(~r/[^0-9\-A-z]/u, "")
        |> String.downcase
        stripped = String.replace_leading(clean, "-", "")
        |> String.replace_trailing("-", "")
        deduped = String.replace(stripped, ~r/\-\-+/u, "-")
        String.slice(deduped, 0, max_text)
      end

    end
  end
end
