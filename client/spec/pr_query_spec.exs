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

      it "returns an ok status" do
        {code, _} = subject()
        expect(code).to eq(:ok)
      end
    end
  end
end
