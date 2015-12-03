defmodule Exercise46 do
  def histogram(file) do
    File.read(file)
    |> words
    |> frequency
    |> sort
    |> format
    |> Enum.join("\n")
    |> IO.puts
  end

  defp words({:ok, content}) do
    content |> String.split
  end

  defp frequency(enum) do
    Enum.reduce(enum, %{}, fn(word, acc) ->
      Map.update(acc, word, 1, &inc/1)
    end)
  end

  defp inc(value) do
    value + 1
  end

  defp sort(enum) do
    enum
    |> Enum.sort_by(fn({word, value}) -> {-value, word} end)
  end

  defp format(enum) do
    enum |> Enum.map(&(format_line(&1, max_word_length(enum))))
  end

  defp longest_word(enum) do
    enum
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.max_by(&String.length/1)
  end

  defp max_word_length(enum) do
    enum
    |> longest_word
    |> String.length
    |> inc
  end

  defp format_line({word, count}, max) do
    "#{String.ljust(word <> ":", max)} #{String.duplicate("*", count)}"
  end
end
