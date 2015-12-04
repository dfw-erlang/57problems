defmodule Exercise46WithStreams do
  def start(path) do
    File.stream!(path)
    |> split_new_lines
    |> remove_punctuation
    |> split_words
    |> parse_list(%{})
    |> display_map
  end

  def split_words(lines) do
    Stream.flat_map(lines, &String.split(&1, " "))
  end

  def split_new_lines(file) do
    Stream.map(file, &String.replace(&1, "\n", ""))
  end

  def remove_punctuation(lines) do
    lines
    |> Stream.map(&String.replace(&1, ~r/[\.\"\'@#$&%^*();\\\/|<>\-\+_,!?]/, ""))
  end

  def parse_list(list, words_map) do
    list
    |> Enum.reduce(words_map, fn(word, acc) ->
      Map.update(acc, word, 1, fn(val) -> val + 1 end)
    end)
  end

  defp display_map(map) do
    map
    |> Enum.sort_by(fn({key, value}) -> {-value, key} end )
    |> Enum.each(fn({key, value}) -> IO.puts "#{String.ljust(key, 25)} #{String.duplicate("*", value)}" end)
  end

end
