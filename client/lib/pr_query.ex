defmodule Client.PrQuery do

  def execute(http \\ HTTPotion) do
    response = call_api(http)

    case response.status_code do
      200 -> {:ok, parse_pull_requests(response.body)}
      _ -> {:error, response.body}
    end
  end

  defp call_api(http) do
    http.get(url(), headers: headers(), query: query())
  end

  defp parse_pull_requests(body) do
    Enum.map(body["items"], fn(item) -> parse_single(item) end)
  end

  defp parse_single(item) do
    item
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
