defmodule Utilities.Detection.LeverCo do
  @moduledoc """
  Documentation for `Utilities.Detection.LeverCo`.
  """

  @doc """
  Get the title element and transform it into markdown

  ## Examples

      iex> html = '<!DOCTYPE html><html lang="en"><head><title>Elixir Engineer at DockYard</title></head><body><div class="content-wrapper posting-page"><p></p></div></body></html>'
      iex> {:ok, document} = Floki.parse_document(html)
      iex> Utilities.Detection.LeverCo.find_description(document)
      [{"div", [{"class", "content-wrapper posting-page"}], [{"p", [], []}]}]

  """
  def find_description(document) do
    document
    |> Floki.find(".content-wrapper.posting-page")
  end

  def transform_description(document) do
    description =
      find_description(document)
      |> hd()
      |> Floki.children(include_text: false)
      |> Floki.traverse_and_update(fn
        {"li", attrs, [text]} -> {"li", attrs, ["[ ] " <> text]}
        tag -> tag
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

      iex> html = '<!DOCTYPE html><html lang="en"><head><title>Elixir Engineer at DockYard</title></head><body><div class="content-wrapper posting-page"><p></p></div></body></html>'
      iex> {:ok, document} = Floki.parse_document(html)
      iex> Utilities.Detection.LeverCo.transform_title(document)
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
