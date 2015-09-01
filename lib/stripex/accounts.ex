defmodule Stripex.Accounts do
  @resource Stripex.Account
  @endpoint "/v1/accounts/:id"
  use Gateway.Resource, update: :post
  
  def all_type, do: %{"data" => [@resource]}
end
