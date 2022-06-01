defmodule UtilitiesTest do
  use ExUnit.Case
  doctest Utilities

  test "greets the world" do
    assert Utilities.hello() == :world
  end
end
