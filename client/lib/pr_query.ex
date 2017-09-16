defmodule Client.PrQuery do

  def execute(http \\ HTTPotion) do
    call_api(http)
    |> handle_response
  end

  defp handle_response(%{status_code: status_code, body: body}) do
    body
    |> Poison.decode!
    |> parse_response_body
    |> return_response(status_code)
  end

  defp handle_response(%{message: _}) do
    {:error, "Query request timed out"}
  end

  defp return_response(body, code) do
    response_code = case code do
      200 -> :ok
      _ -> :error
    end

    {response_code, body}
  end

  defp parse_response_body(response) when is_bitstring(response) do
    response
    |> String.replace("\n", "")
  end

  defp parse_response_body(response) when is_map(response) do
    response["items"]
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
