defmodule Stripex.Plans do
  @resource Stripex.Plan
  @endpoint "/v1/plans/:id"
  use Gateway.Resource, update: :post
  
  def all_type, do: %{"data" => [@resource]}
end