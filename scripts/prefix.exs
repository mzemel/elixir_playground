prefix = fn
  (first_word) -> fn
    (second_word) -> IO.puts "#{first_word} #{second_word}"
  end
end

mrs = prefix.("Mrs.")
mrs.("Smith")

prefix.("Elixir").("Rocks")