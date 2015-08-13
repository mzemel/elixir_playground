defmodule GreatestCommonDivisor do
  def of(x,0), do: x
  def of(x,y), do: of(y,rem(x,y))   
end

IO.puts GreatestCommonDivisor.of(11, 121)