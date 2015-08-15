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

  @subscription_attr %{
    plan: "test",
    source: %{
      "object" => "card",
      "number" => "4242424242424242",
      "exp_month" => 12,
      "exp_year" => 25,
      "cvc" => "666",
      "name" => "Roxy Monster"
    },
    metadata: %{
      "now_playing" => "Hikari Are",
      "artist" => "Maaya Sakamoto",
      "genre" => "Jpop"
    }
  }

  test "it should fetch the test plan" do
    plan = Stripex.Plans.retrieve "test"
    assert plan.id == "test"
  end

  test "retrieving nonexisting resources should return nil" do
    plan = Stripex.Plans.retrieve "non-existent-plan-name"
    refute plan
  end

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

  test "it should allow me to create, update, and destroy subscriptions" do
    [customer|_] = Stripex.Customers.all
    subscription = customer.id |> Stripex.Subscriptions.create(@subscription_attr)
    assert subscription.id
    assert subscription.plan["id"] == @subscription_attr[:plan]
    assert subscription.status == "active"
    assert subscription.metadata == @subscription_attr[:metadata]
    assert subscription.customer == customer.id
    assert subscription.quantity == 1

    subscription = {customer.id, subscription.id} |> Stripex.Subscriptions.update(%{"quantity" => 2})
    assert subscription.quantity == 2

    dead = {customer.id, subscription.id} |> Stripex.Subscriptions.delete
    assert dead.deleted?
    assert dead.type == Stripex.Subscription
    assert dead.id == subscription.id
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
