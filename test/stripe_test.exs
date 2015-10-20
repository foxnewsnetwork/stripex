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

  @card_attr %{
    source: %{
      "object" => "card",
      "number" => "4242424242424242",
      "exp_month" => 12,
      "exp_year" => 25,
      "cvc" => "666",
      "name" => "Roxy Monster"
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
    {:ok, plan} = Stripex.Plans.retrieve "test"
    assert plan.id == "test"
  end

  test "retrieving nonexisting resources should return nil" do
    {:error, error} = Stripex.Plans.retrieve "non-existent-plan-name"
    assert error.status_code == 404
  end

  test "creating a customer, getting a customer, and updating a customer" do
    {:ok, customer} = Stripex.Customers.create @customer_attr
    id = customer.id
    assert id
    assert customer.email == @customer_attr[:email]
    assert customer.description == @customer_attr[:description]
    assert customer.metadata == @customer_attr[:metadata]

    {:ok, customer} = Stripex.Customers.retrieve id
    assert customer.id == id

    {:ok, customer} = Stripex.Customers.update(id, %{email: "dog@do.ge"})
    assert customer.email == "dog@do.ge"
  end

  test "creating a card, getting a card, and updating a card" do
    {:ok, customer} = Stripex.Customers.create @customer_attr
    {:ok, card} = Stripex.Cards.create(customer.id, @card_attr)
    id = card.id
    assert id
    assert card.name == @card_attr[:source]["name"]

    {:ok, card} = Stripex.Cards.retrieve{customer.id, id}
    assert card.id == id

    {:ok, card} = Stripex.Cards.update({customer.id, id}, %{name: "name2"})
    assert card.name == "name2"
  end

  test "it should allow me to create, update, and destroy subscriptions" do
    {:ok, [customer|_]} = Stripex.Customers.all
    {:ok, subscription} = customer.id |> Stripex.Subscriptions.create(@subscription_attr)
    assert subscription.id
    assert subscription.plan["id"] == @subscription_attr[:plan]
    assert subscription.status == "active"
    assert subscription.metadata == @subscription_attr[:metadata]
    assert subscription.customer == customer.id
    assert subscription.quantity == 1

    {:ok, subscription} = {customer.id, subscription.id} |> Stripex.Subscriptions.update(%{"quantity" => 2})
    assert subscription.quantity == 2

    {:ok, sub} = {customer.id, subscription.id} |> Stripex.Subscriptions.delete
    assert sub.id == subscription.id
  end

  test "deleting a customer" do
    {:ok, [customer|_]} = Stripex.Customers.all
    id = customer.id
    assert id
    {:ok, cus} = Stripex.Customers.delete id
    assert cus
    assert cus.id == id
  end

  test "it should get all the customers I have" do
    {:ok, customers} = Stripex.Customers.all
    assert Enum.count(customers) > 0
  end

end
