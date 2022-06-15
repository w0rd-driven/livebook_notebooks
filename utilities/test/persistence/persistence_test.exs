defmodule UtilitiesPersistenceTest do
  use ExUnit.Case
  doctest Utilities.Persistence

  # Test `get_path` returns expected result for at least one example of each.
  # Test `save` checks the file is created and returns its contents.
  # TODO: Test `save` cannot create file.
  # TODO: Test `save` mocks file creation.
  # Test `read` returns contents from local file.
  # TODO: Test `read` mocks contents from url.
end
