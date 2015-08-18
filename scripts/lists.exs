defmodule Lists do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)
end

IO.puts Lists.len([1,2,3])