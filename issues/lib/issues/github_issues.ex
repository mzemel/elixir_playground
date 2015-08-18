defmodule Issues.GithubIssues do

  require Logger

  @user_agent [ {"User-Agent", "Elixir mike@wtf.com"} ]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info "Fetcher user #{user}'s project #{project}"
    issues_url(user, project)
      |> HTTPoison.get(@user_agent)
      |> handle_response
      |> decode_response
      |> convert_to_list_of_hash_dicts
  end

  defp issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, response_struct}) do
    Logger.info "Successful response"
    response_struct.body |> inspect |> Logger.error

    {:ok, response_struct.body}
  end

  def handle_response({:error, response_struct}), do: {:error, response_struct.body}

  def decode_response({:ok, body}), do: :jsx.decode(body)
  def decode_response({:error, body}) do
    {_, message} = List.keyfind(body, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end

  def convert_to_list_of_hash_dicts(list) do
    list
      |> Enum.map(&Enum.into(&1, HashDict.new))
  end


end