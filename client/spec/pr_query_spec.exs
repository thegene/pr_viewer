defmodule Client.PrQuerySpec do
  use ESpec
  import Poison
  import Double

  context "When I execute a PrQuery" do
    subject do: Client.PrQuery.execute(http())

    let :response, do:
      File.read!(fixture())
      |> decode_response

    def decode_response(encoded) do
      Poison.decode!(encoded, as: %HTTPotion.Response{})
    end
    
    let :http, do:
      HTTPotion
      |> double
      |> allow(:get, fn(_url, _opts) -> response() end)

    context "which is successful" do
      let fixture: "spec/fixtures/successful.json"
      let :pr do
        {:ok, pr_list} = subject()
        Enum.at(pr_list, 0)
      end

      it "returns an ok status" do
        {code, _} = subject()
        expect(code).to eq(:ok)
      end

      it "returns an item with a title" do
        expect(pr["title"])
          |> to(eq("Line Number Indexes Beyond 20 Not Displayed"))
      end
    end

    context "which fails with an error" do
      let fixture: "spec/fixtures/missing-user-agent-error.json"

      it "returns an error status" do
        {code, _} = subject()
        expect(code).to eq(:error)
      end

      it "returns the error message" do
        {:error, message} = subject()
        expect(message)
          |> to(eq("Request forbidden by administrative rules. " <>
            "Please make sure your request has a User-Agent header " <>
            "(http://developer.github.com/v3/#user-agent-required). " <>
            "Check https://developer.github.com for other possible causes.\n"))
      end
    end
  end
end
