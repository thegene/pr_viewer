Code.require_file("spec/mocks/response.ex")

defmodule PrRequestSpec do
  use ESpec

  alias Client.Edges
  alias Mocks.Response

  import Double

  context "when I make a request for Pull Requests" do
    subject do: Edges.PrRequest.execute(http())
    
    let :response, do:
      File.read!(fixture())
      |> Response.from_json

    let :http, do:
      HTTPotion
      |> double
      |> allow(:get, fn(_url, _opts) -> response() end)

    context "which is successful" do
      let fixture: "spec/fixtures/successful.json"

      it "Returns a PulRequest with a title" do
        {:ok, items} = subject()
        [head | _] = items

        expect(head.title)
        |> to(eq("Line Number Indexes Beyond 20 Not Displayed"))
      end
    end

    context "which fails with an error message from github" do
      let fixture: "spec/fixtures/missing-user-agent-error.json"

      it "returns the error message" do
        {:error, message} = subject()
        expect(message)
        |> to(eq("Request forbidden by administrative rules. " <>
          "Please make sure your request has a User-Agent header " <>
          "(http://developer.github.com/v3/#user-agent-required). " <>
          "Check https://developer.github.com for other possible causes."))
      end
    end

    context "which fails with an http request timeout" do
      let :response, do:
        %HTTPotion.ErrorResponse{message: "req_timedout"}

      it "returns with a timeout message" do
        {:error, message} = subject()
        expect(message)
        |> to(eq("Query request timed out"))
      end
    end
  end
end
