defmodule Client.Interactions.FetchPullRequests do
  def call(query: query) do

    case query.execute() do
      {:ok, response} -> {:ok, response}
      _ -> {:error, "Query unsuccessful"}
    end
  end
end
