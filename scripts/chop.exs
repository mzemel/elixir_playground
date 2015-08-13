defmodule Chop do
  def guess(number, lower..higher) when number == lower and number == higher do
    IO.puts "It's #{number}!"
  end
  def guess(number, lower..higher) do
    if number > div(higher + lower, 2) do
      IO.puts "Is it #{div(higher + lower, 2)}?"
      guess(number, (div(higher + lower, 2) + 1)..higher)
    else
      IO.puts "Is it #{div(higher + lower, 2)}?"
      guess(number, lower..div(higher + lower, 2))
    end
  end
end

Chop.guess(278, 1..1000)