defmodule Client.Edges.PullRequest do
  defstruct(
    [:title]
  )

  def from_response_item(item) do
    %Client.Edges.PullRequest{
      title: item["title"]
    }
  end
end
