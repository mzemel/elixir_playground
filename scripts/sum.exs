defmodule Sum do
  def of(0), do: 0
  def of(n) when n > 0 do
    n + of(n-1)
  end
end

IO.puts Sum.of(10)

defmodule Math do
  def sum_with_accum([], total), do: total
  def sum_with_accum([head | tail], total), do: sum_with_accum(tail, head + total)

  def sum_without_accum([head | []]), do: head
  def sum_without_accum([head | [head2 | tail]]), do: sum_without_accum([head + head2 | tail])
end

IO.puts Math.sum_with_accum([1,2,3,4,5],0)
IO.puts Math.sum_without_accum([1,2,3,4,5])

#mapsum([1,2,3], &(&1 * &1)) #=> 14

defmodule Math.Two do
  def mapsum(list, func) do
    Math.sum_without_accum(map(list, func))
  end

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]
end

IO.puts "Mapsum:"
IO.puts Math.Two.mapsum([1,2,3,4,5,6], &(&1 * &1))

defmodule Math.Three do
  def max([head | []]), do: head
  def max([head | [head2 | tail]]) when head > head2, do: max([head | tail])
  def max([head | [head2 | tail]]) when head <= head2, do: max([head2 | tail])
end

IO.puts Math.Three.max([72,1,2,3,71,4,5])