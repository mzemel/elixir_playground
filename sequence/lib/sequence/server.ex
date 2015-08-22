defmodule Sequence.Server do
  use GenServer

  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number + 1 }
  end

  def handle_call({:reset_number, new_number}, _from, _current_number) do
    { :reply, new_number, new_number }
  end

  def handle_call({:set_stack, new_stack}, _from, _stack) do
    { :reply, new_stack, new_stack }
  end

  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end

  def handle_cast({:push, value}, stack) do
    { :noreply, [value | stack] }
  end

  def handle_cast({:increment_number, delta}, current_number) do
    { :noreply, current_number + delta }
  end

end