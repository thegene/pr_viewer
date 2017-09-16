defmodule Client.Edges.PrRequest do
  alias Client.Edges.PullRequest

  def execute(http \\ HTTPotion) do
    call_api(http)
    |> parse_response
    |> build_items
    |> respond
  end

  defp parse_response(response) do
    Poison.decode!(response.body)
  end

  defp build_items(response) do
    response["items"]
    |> Enum.map(&(PullRequest.from_response_item(&1)))
  end

  defp respond(item_list) do
    {:ok, item_list}
  end

  defp call_api(http) do
    http.get(url(), headers: headers(), query: query())
  end
    
  defp url do
    base_url = "https://api.github.com"
    path = "search/issues"
    "#{base_url}/#{path}"
  end

  defp headers do
    [
      "accept": "application/vnd.github.v3+json",
      "user-agent": "thegene"
    ]
  end

  defp query do
    %{
      q: "type=pr"
    }
  end
end
