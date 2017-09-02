defmodule Client.Interactions.FetchPullRequestsSpec do
  use ESpec
  alias Client.Interactions

  context "when I fetch a list of pull requests" do
    subject do: Interactions.fetch_pull_requests()

    it "returns a list" do
      expect(subject).to eq([])
    end
  end
end
