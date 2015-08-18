defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI

  test "--help returns help" do
    assert parse_args(["--help", "anything"]) == :help
  end

  test "assert 3 args returns 3 elements in a tuple" do
    assert parse_args(["user", "project", "3"]) == {"user", "project", 3}
  end

  test "assert 2 args gets a 3rd arg added" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sorts into ascending order" do
    result = ~w{b a c}
               |> fake_created_at_list
               |> sort_into_ascending_order
    issues = for issue <- result, do: issue["created_at"]
    assert(~w{a b c}) == issues
  end

  def fake_created_at_list(list) do
    Enum.map list, &(%{created_at: &1, other_data: "xxx"})
  end
end