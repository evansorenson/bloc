defmodule Jirex.Decoder do
  @moduledoc """
  Transform map responses into well-typed structs

  In a normal client stack, the HTTP request is followed by a JSON decoder such as
  `GitHub.Plugin.JasonSerializer`. If the JSON library/plugin does not support decoding typed
  structs, then a separate step is necessary to transform the map responses into structs like
  `GitHub.Repository`. This module provides a two plugins: `decode_response/2` and `normalize_errors/2`, that accept no configuration. `decode_response/2` uses the type information available in the operation and each module's `__fields__/1` functions to decode the data. `normalize_errors/2` changes API error responses into standard `GitHub.Error` results. It is recommended to run these plugins towards the end of the stack, after decoding JSON responses.  The normalized errors will be `GitHub.Error` structs with relevant reason fields where possible.  ## Special Cases There are a few special cases where the decoder must make an inference about which type to use.  If you find that you are unable to decode something, please open an issue with information about the operation and types involved.  Union types often require this kind of inference. This module handles them on a case-by-case basis using required keys to determine the correct type. Some of these are done on a "best guess" basis due to a lack of official documentation.
  """

  require Logger

  @doc """
  Decode a response body based on type information from the operation and schemas
  """
  @spec decode_response(Tesla.Env.t(), keyword) :: {:ok, Operation.t()}
  def decode_response({:error, _} = response, _request), do: response

  def decode_response({:ok, %Tesla.Env{status: code} = response}, %{response: types} = _request) do
    with {:ok, decoded_json} <- decode_body(response, []),
         {:ok, response_type} <- get_type(types, code) do
      IO.inspect(response_type, label: "response_type")
      IO.inspect(decoded_json, label: "decoded_json")

      decoded_body = do_decode_types(decoded_json.body, response_type)
      {:ok, %{response | body: decoded_body}}
    else
      {:error, :not_found} ->
        {:ok, response}
    end
  end

  defp get_type(types, code) do
    if res = Enum.find(types, fn {c, _} -> c == code end) do
      {:ok, elem(res, 1)}
    else
      IO.inspect("#{inspect(types)} - #{code}", label: "not found")
      {:error, :not_found}
    end
  end

  @doc """
  Decode the response body
  """
  @spec decode_body(map(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def decode_body(%Tesla.Env{body: nil} = operation, _opts), do: {:ok, operation}
  def decode_body(%Tesla.Env{body: ""} = operation, _opts), do: {:ok, operation}

  def decode_body(%Tesla.Env{body: body, headers: headers} = response, _opts) do
    if get_content_type(headers) =~ "application/json" do
      case Jason.decode(body) do
        {:ok, decoded_body} ->
          {:ok, %Tesla.Env{response | body: decoded_body}}

        {:error, %Jason.DecodeError{} = decode_error} ->
          {:error,
           "Error while decoding response body #{Jason.DecodeError.message(decode_error)}"}
      end
    else
      {:ok, response}
    end
  end

  @spec get_content_type(Tesla.Env.headers()) :: String.t() | nil
  defp get_content_type([]), do: nil
  defp get_content_type([{"content-type", content_type} | _rest]), do: content_type
  defp get_content_type([{"Content-Type", content_type} | _rest]), do: content_type
  defp get_content_type([_ | rest]), do: get_content_type(rest)

  @doc """
  Manually decode a response

  This function takes a parsed response and decodes it using the given type. It is intended for
  use in testing scenarios only. For regular API requests, use `decode_response/2` as part of the
  client stack.
  """
  @spec decode(term, Operation.type()) :: term
  def decode(response, type) do
    do_decode_types(response, type)
  end

  defp do_decode_types(nil, _), do: nil
  defp do_decode_types("", :null), do: nil
  defp do_decode_types(value, {:string, :date}), do: Date.from_iso8601!(value)
  defp do_decode_types(value, {:string, :date_time}), do: DateTime.from_iso8601(value) |> elem(1)
  defp do_decode_types(value, {:string, :time}), do: Time.from_iso8601!(value)
  defp do_decode_types(value, {:string, :uri}), do: value
  defp do_decode_types(value, {:string, :generic}), do: value
  defp do_decode_types(value, :integer), do: value

  # defp do_decode_types(value, {:union, types}), do: do_decode(value, choose_union(value, types))

  defp do_decode_types(value, {:map, {:string, :any}}), do: value

  defp do_decode_types(value, [type]), do: Enum.map(value, &do_decode_types(&1, type))

  defp do_decode_types(%{} = value, {module, type}) do
    base = if function_exported?(module, :__struct__, 0), do: struct(module), else: %{}
    fields = module.__fields__(type)

    for {field_name, field_type} <- fields, reduce: base do
      decoded_value ->
        case Map.fetch(value, to_string(field_name)) do
          {:ok, field_value} ->
            decoded_field_value = do_decode_types(field_value, field_type)
            Map.put(decoded_value, field_name, decoded_field_value)

          :error ->
            decoded_value
        end
    end
  end

  defp do_decode_types(value, type) do
    raise "Decoder not implemented for #{inspect(type)} with value #{inspect(value)}"
  end
end
