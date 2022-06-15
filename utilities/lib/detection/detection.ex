defmodule Utilities.Detection do
  @moduledoc """
  Documentation for `Utilities.Detection`.
  """

  defp parse_document(html) do
    {:ok, document} = Floki.parse_document(html)
    document
  end

  @doc """
  Find the job description

  ## Examples

      iex> html = '<!DOCTYPE html><html lang="en" xml:lang="en"><head><title></title></head><body></body></html>'
      iex> Utilities.Detection.find_description(html)
      {:unknown, [{"html", [{"lang", "en"}, {"xml:lang", "en"}], [{"head", [], [{"title", [], [""]}]}, {"body", [], []}]}]}

  """
  def find_description(html) do
    document = html |> parse_document()

    cond do
      !Enum.empty?(Utilities.Detection.BreezyHR.find_description(document)) ->
        {:breezy_hr, document}

      !Enum.empty?(Utilities.Detection.LeverCo.find_description(document)) ->
        {:lever_co, document}

      !Enum.empty?(Utilities.Detection.GreenhouseIo.find_description(document)) ->
        {:greenhouse_io, document}

      true ->
        {:unknown, document}
    end
  end
end
