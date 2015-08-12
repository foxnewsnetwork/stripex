defmodule Stripex.Cards do
  @resource Stripex.Card
  @endpoint "v1/customers/:customer_id/cards/:id"
  use Stripex.Resource
end
