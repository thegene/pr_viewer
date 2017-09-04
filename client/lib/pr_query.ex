defmodule Client.PrQuery do

  def execute(http \\ HTTPotion) do
    {:ok, get(http).body}
  end

  defp get(http) do
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
