defmodule Jirex.Client do
  alias Jirex.Decoder
  alias Jirex.TeslaClient

  def request(request) do
    TeslaClient.new()
    |> TeslaClient.request(Map.to_list(request))
    |> Decoder.decode_response(request)
  end
end
