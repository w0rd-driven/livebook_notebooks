defmodule Utilities.Detection do
  @moduledoc """
  Documentation for `Utilities.Detection`.
  """

  defp parse_document(html) do
    {:ok, document} = Floki.parse_document(html)
    document
  end

  def find_breezy(html) do
    html
    |> parse_document
    |> Floki.find(".breezy-portal .description")
  end

  defp find_lever(html) do
    html
    |> parse_document
    |> Floki.find(".content-wrapper posting-page")
  end

  defp find_greenhouse(html) do
    html
    |> parse_document
    |> Floki.find("#main.accessible #app_body")
  end

  defp find_unknown(html) do
    html
    |> parse_document
  end

  @doc """
  Find the job description

  ## Examples

      iex> html = "<html></html>"
      iex> Utilities.Persistence.find_description(html)
      {:unknown, []}

  """
  def find_description(html) do
    cond do
      !Enum.empty?(find_breezy(html)) -> {:breezy_hr, find_breezy(html)}
      !Enum.empty?(find_lever(html)) -> {:lever_co, find_lever(html)}
      !Enum.empty?(find_greenhouse(html)) -> {:lever_co, find_greenhouse(html)}
      true -> {:unknown, find_unknown(html)}
    end
  end
end
