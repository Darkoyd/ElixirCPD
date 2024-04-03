defmodule T3 do
  @doc """
  Count the number of words in a sentence.

  Words are case insensitive and are separated by any break.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/\W+/)
    |> Enum.reduce(%{}, fn word, acc ->
      Map.update(acc, word, 1, &(&1 + 1))
    end)
  end
end
