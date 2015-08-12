defmodule Stripex.Response do

  @type t :: %Stripex.Response{
    status_code: number,
    data: term,
    success?: boolean,
    errors: list,
    raw_response: Stripex.Response.http_poison_response
  }
  @type http_poison_response :: %{
    status_code: number,
    body: String.t,
    headers: list
  }

  defstruct data: nil,
            raw_response: nil,
            status_code: nil,
            success?: true,
            errors: []

  @spec new({:ok, HTTPoison.Response}) :: Stripex.Response | {:error, term}
  def new(response) do
    new(response, %{})
  end

  @spec new({:ok, HTTPoison.Response}, map) :: Stripex.Response | {:error, term}
  def new({:ok, response}, options) do
    case parse_body(response, options) do
      {:ok, data} ->
        wrap_success(data, response)    
      {:error, error} ->
        wrap_failure(error, response)
    end
  end

  defp wrap_failure(error, response) do
    response = wrap_success(error, response)
    errors = Map.to_list error["error"]
    %{response | success?: false, errors: errors }
  end

  defp wrap_success(data, %{status_code: c}=response) do
    %Stripex.Response{ data: data, raw_response: response, status_code: c }
  end

  defp parse_body(response, options) do
    case Poison.decode(response.body) do
      {:ok, data} ->
        if success? response do
          {:ok, cast_data(data, options)}
        else
          {:error, data}
        end
      error ->
        {:error, error}
    end
  end

  @spec success?(%{status_code: number}) :: boolean
  defp success?(%{status_code: 200}) do
    true
  end
  defp success?(_), do: false

  @spec cast_data(map, map)   :: {:ok, map}
  @spec cast_data(list, map)  :: {:ok, list(map)}
  # If there is a "data" field present (for list responses), pull that out
  defp cast_data(%{"data" => data}, options) do
    cast_data(data, options)
  end

  # Just pull out known keys on the passed in `as: struct`, other than the
  # :__struct__ key
  defp cast_data(data, %{as: as_struct}) when is_map(data) do
    struct_keys = Map.keys(as_struct.__struct__) |> List.delete :__struct__
    struct(as_struct, Stripex.Utils.safe_atomize_keys(data, struct_keys))
  end

  # For lists, loop over them and cast their members
  defp cast_data(data, %{as: _struct}=options) when is_list(data) do
    Enum.map data, &cast_data(&1, options)
  end

  # If no :as option is passed, just return the data as is
  defp cast_data(data, _options) do
    data
  end
end
