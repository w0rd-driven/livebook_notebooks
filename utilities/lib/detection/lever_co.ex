defmodule Utilities.Detection.LeverCo do
  @moduledoc """
  Documentation for `Utilities.Detection.LeverCo`.
  """

  def find_description(document) do
    document
    |> Floki.find(".content-wrapper posting-page")
  end
end
