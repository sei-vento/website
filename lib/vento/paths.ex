defmodule Vento.Paths do
  def path_with_locale_prefix(path, locale) when is_binary(path) and is_atom(locale) do
    Path.join(locale_url_prefix(locale), path)
  end

  def locale_url_prefix(:en), do: "/"
  def locale_url_prefix(locale), do: "/#{locale}/"
end
