defmodule Stripex.Subscriptions do
  @resource Stripex.Subscription
  @endpoint "v1/customers/:customer_id/subscriptions/:id"
  use Stripex.Resource
end