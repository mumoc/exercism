defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".")

    extract(data, keys)
  end

  def extract(data, []), do: data
  def extract(data, [key | rest]) do
    case Access.fetch(data, key) do
      {:ok, value} -> extract(value, rest)
      :error -> nil
    end
  end

  def get_in_path(data, path) do
    keys = String.split(path, ".")
    Kernel.get_in(data, keys)
  end
end
