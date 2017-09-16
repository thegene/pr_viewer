defmodule Client.Interactions.FetchPullRequests do
  def call(list: list) do

    case list.fetch() do
      {:ok, response} -> {:ok, response}
      _ -> {:error, "Query unsuccessful"}
    end
  end

  def call do
    call(query: Client.PrQuery)
  end
end
