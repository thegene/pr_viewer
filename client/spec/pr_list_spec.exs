defmodule Client.PrListSpec do
  use ESpec

  alias Mocks.Response

  import Double

  context "When I fetch a PrList" do
    subject do: Client.PrList.fetch(http())
  end
end
