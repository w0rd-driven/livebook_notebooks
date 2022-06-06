defmodule Utilities.Detection.GreenhouseIo do
  @moduledoc """
  Documentation for `Utilities.Detection.GreenhouseIo`.
  """

  def find_description(document) do
    document
    |> Floki.find("#main.accessible #app_body")
  end
end
