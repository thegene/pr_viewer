defmodule Mocks.Response do
  import Poison

  defstruct(
    body: "",
    status_code: "",
    headers: {}
  )

  def from_json(json) do
    Poison.decode!(json, as: %Mocks.Response{})
    |> re_encode_body
  end

  defp re_encode_body(%Mocks.Response{
                                      body: body,
                                      headers: headers,
                                      status_code: status_code}) do
    %Mocks.Response{
      body: Poison.encode!(body),
      headers: headers,
      status_code: status_code
    }
  end
end
