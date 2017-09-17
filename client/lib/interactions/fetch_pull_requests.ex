defmodule Client.Interactions.FetchPullRequests do
  def call(list \\ Client.PrList) do

    case list.fetch(request: request()) do
      {:ok, response} -> {:ok, response}
      _ -> {:error, "Query unsuccessful"}
    end
  end

  defp request do
    Client.Edges.PrRequest
  end
end
