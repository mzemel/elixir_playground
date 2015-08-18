defmodule Issues.CLI do

  import Issues.TableFormatter, only: [print_table_for_columns: 2]

  @default_count 4

  def main(argv) do
    argv
      |> parse_args
      |> process
  end

  @doc """
  Generic help message
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h: :help      ])

    case parse do
      { [ help: true ], _, _ }
        -> :help

      { _, [ user, project, count ], _ }
        -> { user, project, String.to_integer(count) }

      { _, [ user, project], _ }
        -> { user, project, @default_count }

      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
     |> sort_into_ascending_order
     |> Enum.take(count)
     |> print_table_for_columns(["number", "created_at", "title"])
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort list_of_issues,
      fn i1, i2 -> i1["created_at"] <= i2["created_at"] end
  end

end