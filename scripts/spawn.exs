defmodule Spawn do
  def greet do
    receive do
      {sender, msg} -> 
        send sender, { :ok, "Hello, #{msg}" }
        greet
    end
  end
end

pid = spawn(Spawn, :greet, [])
send pid, {self, "World!"}

receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self, "Michael"}
receive do
  {:ok, message} ->
    IO.puts message
end