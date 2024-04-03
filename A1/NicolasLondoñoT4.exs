defmodule T4 do
  @doc """
  Searches for a key in the tuple using the binary search algorithm.
   It returns :not_found if the key is not in the tuple.
   Otherwise returns { :ok , index } .
  """
  @spec search(tuple, integer) :: {:ok, integer} | :not_found

  def search(tuple, integer) do
    list = tuple |> Tuple.to_list()
    middle = (length(list) / 2) |> round()
    elem = Enum.at(list, middle)

    if elem == integer do
      {:ok, integer}
    else
      if elem == nil do
        :not_found
      else
        if elem > integer do
          search(list |> Enum.slice(0, middle) |> List.to_tuple(), integer)
        else
          search(list |> Enum.slice(middle, length(list)) |> List.to_tuple(), integer)
        end
      end
    end
  end
end
