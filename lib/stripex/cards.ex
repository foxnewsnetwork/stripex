defmodule Stripex.Cards do
  @resource Stripex.Card
  @endpoint "/v1/customers/:customer_id/sources/:id"
  use Gateway.Resource, update: :post

  def all_type, do: %{"data" => [@resource]}
end
