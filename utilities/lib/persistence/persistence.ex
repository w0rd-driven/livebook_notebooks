defmodule Utilities.Persistence do
  @moduledoc """
  Documentation for `Utilities.Persistence`.
  """

  @base_directory Path.join([".", "data", "jobs"])

  @doc """
  Get the relative directory and file name.

  ## Examples

      iex> url = "https://dockyard.breezy.hr/p/96e88139f744-elixir-engineer"
      iex> Utilities.Persistence.get_path(url)
      {"dockyard.breezy.hr", "bb1ed676b37e1bdf21af4ae430f086c85ff434a7.html"}

  """
  def get_path(url, extension \\ "html") do
    parts = URI.parse(url)
    hash = :crypto.hash(:sha, url) |> Base.encode16(case: :lower)
    {parts.host, "#{hash}.#{extension}"}
  end

  @doc """
  Save the contents to the path returned from `get_path(url, extension)`.

  ## Examples

      iex> url = "https://dockyard.breezy.hr/p/96e88139f744-elixir-engineer"
      iex> Utilities.Persistence.save(url, contents)
      "..."

  """
  def save(url, contents, extension \\ "html") do
    {directory, filename} = get_path(url, extension)
    directory_path = Path.join([@base_directory, directory])
    file_path = Path.join(directory_path, filename)
    File.mkdir_p!(directory_path)
    io_device = File.open!(file_path, [:write, :binary, :utf8])
    :ok = IO.write(io_device, contents)
    :ok = File.close(io_device)
    contents
  end

  defp get_from_url(url, extension) do
    request = Req.new(http_errors: :raise)

    contents = Req.get!(request, url: url).body
    save(url, contents, extension)
  end

  @doc """
  Read the `['html', 'md']` contents from disk or by `get_from_url(url, extension)`.

  ## Examples

      iex> url = "https://dockyard.breezy.hr/p/96e88139f744-elixir-engineer"
      iex> Utilities.Persistence.read(url)
      "..."

  """
  def read(url, extension \\ "html") do
    {directory, filename} = get_path(url, extension)
    file_path = Path.join([@base_directory, directory, filename])

    if File.exists?(file_path) do
      File.read!(file_path)
    else
      get_from_url(url, extension)
    end
  end
end
