# Utilities

Utilities for use with the included Livebook notebooks.

It's easier to break these out into their own mix project to add things like test cases. Livebook isn't a terrible place for modules but refactoring can be a little more of a chore.

## Installation

```elixir
Mix.install([
  # ... Other dependencies
  {:utilities, path: "utilities"}
])
```
