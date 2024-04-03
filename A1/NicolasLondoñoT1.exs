defmodule T1 do

  @type kind ::  :equilateral | :isoceles | :scalene

  @doc """
  Return the kind of triangle given the lengths of its sides.
  """
  @spec kind(number, number, number)  :: {:ok, kind} | {:error, String.t}
  def kind(a, b, c) when a > 0 and b > 0 and c > 0 do
    case {a, b, c} do
      {a, b, c} when a + b <= c or a + c <= b or b + c <= a ->
        {:error, "Not a valid triangle"}
      {a, b, c} when a == b and b == c ->
        {:ok, :equilateral}
      {a, b, c} when a == b or b == c or a == c ->
        {:ok, :isoceles}
      {a, b, c} ->
        {:ok, :scalene}
    end
  end

end
