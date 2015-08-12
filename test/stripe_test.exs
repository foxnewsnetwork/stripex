defmodule StripexTest do
  use ExUnit.Case

  setup do
    Stripex.start
  end

  @customer_attr %{ 
    email: "stripex.test@mailinator.com",
    description: "stripex testing customer",
    metadata: %{
      now_playing: "Halycon",
      artist: "Reol",
      genre: "Jpop"
    }
  }

  test "creating a customer" do
    customer = Stripex.Customers.create @customer_attr
    assert customer.data
    assert customer.errors == []
    assert customer.success?
  end
end
