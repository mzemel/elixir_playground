fizzbuzz = fn
  {0, 0, _} -> "fizzbuzz"
  {0, _, _} -> "fizz"
  {_, 0, _} -> "buzz"
  {_, _, third} -> third
end

IO.puts "#{fizzbuzz.({0,0,3})} should be fizzbuzz"
IO.puts "#{fizzbuzz.({0,1,3})} should be fizz"
IO.puts "#{fizzbuzz.({1,0,3})} should be buzz"
IO.puts "#{fizzbuzz.({1,1,3})} should be 3"

rem_fizzbuzz = fn
  n -> IO.puts fizzbuzz.({rem(n,3), rem(n,5), n})
end

10..16 |> Enum.each &rem_fizzbuzz.(&1)