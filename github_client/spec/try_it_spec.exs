defmodule TryItSpec do
  use ESpec

  context "try it out" do
    it "works" do
      expect true |> to(be_true())
    end
  end
end
