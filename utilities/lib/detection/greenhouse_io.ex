defmodule Utilities.Detection.GreenhouseIo do
  @moduledoc """
  Documentation for `Utilities.Detection.GreenhouseIo`.
  """

  def find_description(document) do
    document
    |> Floki.find("#main.accessible #app_body")
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

  def transform_title(document) do
    title =
      Floki.find(document, "title")
      |> hd()
      |> Floki.raw_html()

    # Since this is a single tag we can just convert it to Markdown directly
    title |> String.replace("<title>", "") |> String.replace("</title>", "")
  end
end
