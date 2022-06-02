defmodule Utilities.Persistence do
  @base_directory Path.join([".", "data", "jobs"])

  def get_path(url, extension \\ "html") do
    parts = URI.parse(url)
    hash = :crypto.hash(:sha, url) |> Base.encode16(case: :lower)
    {parts.host, "#{hash}.#{extension}"}
  end

  def exists?(path) do
    {directory, filename} = path
    file_path = Path.join([@base_directory, directory, filename])
    File.exists?(file_path)
  end

  def save(path, contents, _overwrite \\ true) do
    {directory, filename} = path
    directory_path = Path.join([@base_directory, directory])
    file_path = Path.join(directory_path, filename)
    File.mkdir_p!(directory_path)
    io_device = File.open!(file_path, [:write, :binary, :utf8])
    :ok = IO.write(io_device, contents)
    :ok = File.close(io_device)
    contents
  end

  def read(path) do
    {directory, filename} = path
    file_path = Path.join([@base_directory, directory, filename])
    File.read!(file_path)
  end
end
