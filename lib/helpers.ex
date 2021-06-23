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
      
      import Website.Paths
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
              title
              slug
              imageHero {
                responsiveImage(sizes: "(min-width: 1600px) 100vw, 100vw",
                imgixParams: {auto: [compress,format], fit: crop, w: "2545"}) {
                  #{responsive_image_fragment()}
                }
                blurUpThumb  
              }
              titleHero
              body {
                blocks {
                  ... on GalleryBlockRecord {
                    id
                  }
                  ... on ImageBlockRecord {
                    id
                  }
                  ... on TextBlockRecord {
                    id
                  }
                  ... on TextImageBlockRecord {
                    id
                  }
                  ... on VideoBlockRecord {
                    id
                  }
                }
              }                                          
            }
          }
          """, %{locale: locale})

        result[:homePage]
      end
    
      defmemo blog_index(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            blogIndex(locale: $locale) {
              _modelApiKey
              _updatedAt
              title
              slug
              menuLabel
              imageHero {
                responsiveImage(sizes: "(min-width: 1024px) 60vw, 100vw",
                imgixParams: {auto: [compress,format], fit: crop, w: "1024", h: 450}) {
                  #{responsive_image_fragment()}
                }
                blurUpThumb
              }
              titleHero
              body {
                blocks {
                  ... on GalleryBlockRecord {
                    id
                  }
                  ... on ImageBlockRecord {
                    id
                  }
                  ... on TextBlockRecord {
                    id
                  }
                  ... on TextImageBlockRecord {
                    id
                  }
                  ... on VideoBlockRecord {
                    id
                  }
                }
              }                                          
              #{seo_meta_tags_fragment()}                                                                                     
            }
          }
          """, %{locale: locale})
        
        result[:blogIndex]
      end
    
      defmemo blog_posts(locale) do
        DatoCMS.GraphQLClient.fetch_all_localized!(
          :allBlogPosts,
          locale,          
          """
          {
            _modelApiKey
            _updatedAt
            title
            slug
            id
            imageHero {
              responsiveImage(sizes: "(min-width: 1024px) 60vw, 100vw",
              imgixParams: {auto: [compress,format], fit: crop, w: "1024", h: 450}) {
                #{responsive_image_fragment()}
              }
              blurUpThumb
            }
            titleHero
            body {
              blocks {
                ... on GalleryBlockRecord {
                  id
                }
                ... on ImageBlockRecord {
                  id
                }
                ... on TextBlockRecord {
                  id
                }
                ... on TextImageBlockRecord {
                  id
                }
                ... on VideoBlockRecord {
                  id
                }
              }
            }                                          
            #{seo_meta_tags_fragment()}                                                                                     
          }
          """
        )    
      end
    
      defmemo contact_page(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            contactPage(locale: $locale) {
              _modelApiKey
              _updatedAt
              title
              slug
              menuLabel
              imageHero {
                responsiveImage(sizes: "(min-width: 1024px) 60vw, 100vw",
                imgixParams: {auto: [compress,format], fit: crop, w: "1024", h: 450}) {
                  #{responsive_image_fragment()}
                }
                blurUpThumb
              }
              titleHero
              body {
                blocks {
                  ... on GalleryBlockRecord {
                    id
                  }
                  ... on ImageBlockRecord {
                    id
                  }
                  ... on TextBlockRecord {
                    id
                  }
                  ... on TextImageBlockRecord {
                    id
                  }
                  ... on VideoBlockRecord {
                    id
                  }
                }
              }                                          
              #{seo_meta_tags_fragment()}                                                                                     
            }
          }
          """, %{locale: locale})    
        
        result[:contactPage]
      end
    
      defmemo info(locale) do
        result = query!("""
          query MyQuery($locale: SiteLocale!) {
            info(locale: $locale) {
              copyFooter
              email
              emailForm
              phone {
                number
                label
              }
              social {
                link
                title
                icon {
                  url
                }
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
            }
          }
          """, %{locale: locale})    
        
        result[:info]
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
          "blog_post" -> blog_index(locale)
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
