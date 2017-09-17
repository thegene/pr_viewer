defmodule Client.PrListSpec do
  use ESpec

  alias Client.Edges.PrRequest

  import Double

  context "When I fetch a PR List from a request" do
    subject do: Client.PrList.fetch(request: request())

    let :request do
      double(PrRequest)
      |> allow(:execute, fn -> {code(), response()} end)
    end

    context "which is successful" do
      let code: :ok
      let response: []

      let :items do
        {:ok, items} = subject()
        items
      end

      it "returns this response" do
        expect(items())
        |> to(eq(response()))
      end
    end
  end
end
