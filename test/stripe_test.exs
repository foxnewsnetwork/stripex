defmodule StripexTest do
  use ExUnit.Case

  setup do
    Stripex.start
  end

  @customer_attr %{ 
    email: "stripex.spec@invisible.com",
    description: "stripex testing customer",
    metadata: %{
      "now_playing" => "Halycon",
      "artist" => "Reol",
      "genre" => "Jpop"
    }
  }

  test "creating a customer, getting a customer, and updating a customer" do
    customer = Stripex.Customers.create @customer_attr
    id = customer.id
    assert id
    assert customer.email == @customer_attr[:email]
    assert customer.description == @customer_attr[:description]
    assert customer.metadata == @customer_attr[:metadata]

    customer = Stripex.Customers.retrieve id
    assert customer.id == id

    customer = Stripex.Customers.update(id, %{email: "dog@do.ge"})
    assert customer.email == "dog@do.ge"
  end

  test "deleting a customer" do
    [customer|_] = Stripex.Customers.all
    id = customer.id
    assert id
    dead = Stripex.Customers.delete id
    assert dead
    assert dead.deleted?
    assert dead.type == Stripex.Customer
    assert dead.id == id
  end

  test "it should get all the customers I have" do
    customers = Stripex.Customers.all
    assert Enum.count(customers) > 0
  end
end
