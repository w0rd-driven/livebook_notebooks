defmodule Utilities.Persistence do
  @base_directory Path.join([".", "data", "jobs"])

  def get_path(url, extension \\ "html") do
    parts = URI.parse(url)
    hash = :crypto.hash(:sha, url) |> Base.encode16(case: :lower)
    {parts.host, "#{hash}.#{extension}"}
  end

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
