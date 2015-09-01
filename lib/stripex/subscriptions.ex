defmodule Stripex.Subscriptions do
  @resource Stripex.Subscription
  @endpoint "/v1/customers/:customer_id/subscriptions/:id"
  use Gateway.Resource, update: :post
  
  def all_type, do: %{"data" => [@resource]}
end