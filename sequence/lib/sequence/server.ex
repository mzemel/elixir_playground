defmodule Sequence.Server do
  use GenServer

  #####
  # External API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  #####
  # GenServer Implementation

  def init(stash_pid) do
    current_number = Sequence.Stash.get_value(stash_pid)
    {:ok, {current_number, stash_pid}}
  end

  def handle_call(:next_number, _from, {current_number, stash_pid}) do
    { :reply, current_number, {current_number + 1, stash_pid} }
  end

  # def handle_call({:reset_number, new_number}, _from, _current_number) do
  #   { :reply, new_number, new_number }
  # end

  # def handle_call({:set_stack, new_stack}, _from, _stack) do
  #   { :reply, new_stack, new_stack }
  # end

  # def handle_call(:pop, _from, [head | tail]) do
  #   { :reply, head, tail }
  # end

  # def handle_cast({:push, value}, stack) do
  #   { :noreply, [value | stack] }
  # end

  def handle_cast({:increment_number, delta}, {current_number, stash_pid}) do
    { :noreply, {current_number + delta, stash_pid} }
  end

  def terminate(_reason, {current_number, stash_pid}) do
    Sequence.Stash.save_value stash_pid, current_number
  end

end