defmodule Stripex.Customer do
@moduledoc """
  The Struct and type spec information for a Stripex Customer
  """

  @type t :: %Stripex.Customer{
                     id: String.t,
                 object: String.t,
                created: number,
               livemode: boolean,
            description: String.t,
             delinquent: boolean,
               metadata: map,
          subscriptions: list(Stripex.Subscription),
               discount: Stripex.Discount | nil,
        account_balance: number,
               currency: String.t,
                  cards: list(Stripex.Card),
           default_card: String.t | Stripex.Card | nil
  }

  defstruct          id: "",
                 object: "customer",
                created: 0,
               livemode: false,
            description: "",
             delinquent: false,
               metadata: %{},
          subscriptions: [],
               discount: nil,
        account_balance: 0,
               currency: "usd",
                  cards: [],
           default_card: nil
end
