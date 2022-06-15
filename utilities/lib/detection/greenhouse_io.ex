defmodule Utilities.Detection.GreenhouseIo do
  @moduledoc """
  Documentation for `Utilities.Detection.GreenhouseIo`.
  """

  @doc """
  Get the title element and transform it into markdown

  ## Examples

      iex> html = '<!DOCTYPE html><html lang="en"><head><title>Sr. Backend Architect</title></head><body><div id="wrapper><div id="main" class="accessible"><div id="app_body"></div></div></div></body></html>'
      iex> {:ok, document} = Floki.parse_document(html)
      iex> Utilities.Detection.GreenhouseIo.find_description(document)
      [{"div", [{"id", "app_body"}], []}]

  """
  def find_description(document) do
    document
    |> Floki.find("#app_body")
  end

  def transform_description(document) do
    description =
      find_description(document)
      |> hd()
      |> Floki.children(include_text: false)
      |> Floki.traverse_and_update(fn
        {"li", attrs, [text]} ->
          cond do
            is_binary(text) ->
              {"li", attrs, ["[ ] " <> text]}

            is_tuple(text) ->
              Floki.traverse_and_update(text, fn
                {_, _attrs, [text]} -> {"li", [], ["[ ] " <> text]}
              end)

            true ->
              {"li", attrs, [text]}
          end

        tag ->
          tag
      end)
      |> Floki.raw_html()

    {:ok, markdown} = Pandex.html_to_markdown_strict(description)

    markdown_title = transform_title(document)

    # Cleanup escaped brackets [ ]
    content = markdown |> String.replace("\\[ \\]", "[ ]") |> String.replace("-   [ ]", "* [ ]")

    # Inject our title as the first line
    markdown_content = "# #{markdown_title}\n\n" <> content

    [title: markdown_title, content: markdown_content]
  end

  @doc """
  Get the title element and transform it into markdown

  ## Examples

      iex> html = '<!DOCTYPE html><html ng-app="PortalApp" prefix="og: http://ogp.me/ns#" lang="en" xml:lang="en"><head><title>Elixir Engineer at DockYard</title></head><body></body></html>'
      iex> {:ok, document} = Floki.parse_document(html)
      iex> Utilities.Detection.GreenhouseIo.transform_title(document)
      "Elixir Engineer at DockYard"

  """
  def transform_title(document) do
    title =
      Floki.find(document, "title")
      |> hd()
      |> Floki.raw_html()

    # Since this is a single tag we can just convert it to Markdown directly
    title |> String.replace("<title>", "") |> String.replace("</title>", "")
  end
end
