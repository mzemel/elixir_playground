defmodule Sum do
  def of(0), do: 0
  def of(n) when n > 0 do
    n + of(n-1)
  end
end

IO.puts Sum.of(10)