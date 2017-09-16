defmodule Client.Edges.PrRequest do
  alias Client.Edges.PullRequest

  def execute(http \\ HTTPotion) do
    call_api(http)
    |> parse_api_response
    |> build_response
  end

  defp parse_api_response(%{body: body, status_code: code}) do
    parsed = Poison.decode!(body)

    case code do
      200 -> {:ok, parsed}
      _ -> {:error_message, parsed}
    end
  end

  defp parse_api_response(%{message: "req_timedout"}) do
    {:error_message, "Query request timed out"}
  end

  defp build_response({:ok, api_response}) do
    {:ok, api_response["items"] |> cast_items }
  end

  defp build_response({:error_message, message}) do
    {:error, message |> String.replace("\n", "")}
  end

  defp call_api(http) do
    http.get(url(), headers: headers(), query: query())
  end

  defp cast_items(items) do
    items
    |> Enum.map(&(PullRequest.from_response_item(&1)))
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
