defmodule Stripex.Response do

  @type t :: %Stripex.Response{
    status_code: number,
    model: term,
    success?: boolean,
    errors: list,
    raw_response: Stripex.Response.http_poison_response
  }
  @type http_poison_response :: %{
    status_code: number,
    body: String.t,
    headers: list
  }

  defstruct model: nil,
            raw_response: nil,
            status_code: nil,
            success?: true,
            errors: []

  @spec new({:ok | :error, HTTPoison.Response}, atom) :: Stripex.Response
  def kill({:ok, response}, type) do
    case Poison.decode(response.body) do
      {:ok, %{"id" => id}} -> 
        %Stripex.Killed{id: id, type: type} |> wrap_success(response)
      {:error, error} -> wrap_failure error, response
    end
  end
  def kill({:error, response}, type) do
    new({:error, response}, type)
  end

  @spec new({:ok | :error, HTTPoison.Response}, atom | [atom]) :: Stripex.Response
  def new({:ok, response}, types) when is_list(types) do
    case new({:ok, response}, %{"data" => types}) do
      %{success?: true, model: %{"data" => resources}} -> wrap_success(resources, response)
      error_response -> error_response
    end
  end
  def new({:ok, response}, type) do
    case Poison.decode(response.body, as: type) do
      {:ok, resource} -> wrap_success resource, response
      {:error, error} -> wrap_failure error, response
    end
  end
  def new({:error, response}, _) do
    errors = Map.to_list response.body
    %Stripex.Response{success?: false, raw_response: response, status_code: response.status_code, errors: errors}
  end

  defp wrap_failure(error, %{status_code: c}=response) do
    errors = [error, {:parse_error, "malformed json"}]
    %Stripex.Response{ success?: false, raw_response: response, status_code: c, errors: errors }
  end

  defp wrap_success(model, %{status_code: c}=response) do
    %Stripex.Response{ model: model, raw_response: response, status_code: c }
  end

end
