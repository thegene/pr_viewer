defmodule Client.Interactions.FetchPullRequestsSpec do
  use ESpec
  import Double
  alias Client.Interactions

  let :subject, do: Interactions.FetchPullRequests.call(list: list())
  let :list, do:
    Client.PrList
    |> double
    |> allow(:fetch, fn() -> {response_code(), response()} end)

  context "when I successfully fetch a list of pull requests" do
    let response_code: :ok, response: []

    it "returns a list" do
      expect(subject()).to eq({:ok, []})
    end
  end

  context "when the list returns an error" do
    let response_code: :error, response: []

    it "returns an error message" do
      expect(subject()).to eq({:error, "Query unsuccessful"})
    end
  end
end
