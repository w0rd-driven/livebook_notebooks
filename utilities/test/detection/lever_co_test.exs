defmodule UtilitiesDetectionLeverCoTest do
  use ExUnit.Case
  doctest Utilities.Detection.LeverCo

  # Test `find_description` returns the description or empty list []
  # Test `transform_description` returns the keyword list as [title: markdown_title, content: markdown_content]
  # Test `transform_title` returns the title
end
