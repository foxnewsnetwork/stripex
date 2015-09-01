# StripeX

Another implementation of the Stripe API client for Elixir, based off of: https://github.com/SenecaSystems/stripe

This one is built on top of httpoison and poison instead of httpotion and jazz.

** Work in progress **

## Scope

The goal is to map all objects in the Stripe API 1-1

Because Elixir is essentially Ruby with a tan and a different colored blouse, StripeX attempts to mimic ruby_stripe's API as closely as reasonable.

### TODO List
Things to do haven't been checked.

#### Resources

- [ ] Charges
- [ ] Refunds
- [x] Customers
- [x] Cards
- [x] Subscriptions
- [x] Plans
- [ ] Coupons
- [ ] Discounts
- [ ] Invoices
- [ ] Invoice Items
- [ ] Disputes
- [ ] Transfers
- [ ] Recipients
- [ ] Application Fees
- [ ] Application Fee Refunds
- [x] Account
- [ ] Balance
- [ ] Events
- [ ] Tokens

#### Methods
- [x] retrieve
- [x] all
- [x] update
- [x] delete
- [x] create

#### Features

- [ ] Cast nested resources

#### Testing

- [ ] Write more tests (lol)

## Authentication

Authentication for Stripe's API is done via a single Bearer token. The library will check the `STRIPE_SECRET_KEY` environment variable and fallback `to Application.get_env(:stripe, :secret_key)`.

## Usage

The RESTfulness of the Stripe API makes this easy. In essence, for every object
in the Stripe ecosystem, we should be able to make calls such as:

```Elixir
Stripe.start

{:ok, customer} = Stripe.Customers.create %{email: "you@example.co", description: "whatever", source: "token_1234"}

{:ok, customers} = Stripe.Customers.all
# => [%Stripe.Customer{account_balance: 0,...]

length customers
# => 10

customer = List.first customers
  # => %Stripe.Customer{account_balance: 0,
  #      cards: %{"data" => [%{"address_city" => nil, "address_country" => nil,
  #            "address_line1" => nil, "address_line1_check" => nil,
  #            "address_line2" => nil, "address_state" => nil, "address_zip" => nil,
  #            "address_zip_check" => nil, "brand" => "Visa", "country" => "US",
  #            "customer" => "cus_5HYg9UxTAsC84D", "cvc_check" => "pass",
  #            "dynamic_last4" => nil, "exp_month" => 11, "exp_year" => 2016,
  #            "fingerprint" => "Xt5EWLLDS7FJjR1c", "funding" => "credit",
  #            "id" => "card_156zZS2eZvKYlo2CcevEs4Be", "last4" => "4242", "name" => nil,
  #            "object" => "card"}], "has_more" => false, "object" => "list",
  #         "total_count" => 1, "url" => "/v1/customers/cus_5HYg9UxTAsC84D/cards"},
  #      created: 1417937711, currency: nil,
  #      default_card: "card_156zZS2eZvKYlo2CcevEs4Be", delinquent: false,
  #      description: "erikyuzwa@gmail.com", discount: nil, id: "cus_5HYg9UxTAsC84D",
  #      livemode: false, metadata: %{}, object: "customer",
  #      subscriptions: %{"data" => [], "has_more" => false, "object" => "list",
  #         "total_count" => 0,
  #         "url" => "/v1/customers/cus_5HYg9UxTAsC84D/subscriptions"}}

# Get a customer by ID
customer_id = customer.id # cus_xxx000111 or whatever
Stripe.Customers.retrieve customer_id
# => {:ok, %Stripe.Customer{account_balance: 0, ...}}

# Get a card (nested under customers)
Stripe.Cards.retrieve {customer_id, customer.default_card}
# => {:ok, %Stripe.Card{address_city: nil, address_country: nil, address_line1: nil,
#         address_line1_check: nil, address_line2: nil, address_state: nil,
#         address_zip: nil, address_zip_check: nil, brand: "Visa", country: "US",
#         customer: "cus_5HYg9UxTAsC84D", cvc_check: "pass", dynamic_last4: nil,
#         exp_month: 11, exp_year: 2016, fingerprint: "Xt5EWLLDS7FJjR1c",
#         funding: "credit", id: "card_156zZS2eZvKYlo2CcevEs4Be", last4: "4242",
#         name: nil, object: "card"}}
```

Consult the `test/stripe_test.exs` file for a better idea of how to use this library.

### Testing
This library isn't yet fully tested... but to run the tests we have, here's what you must do:

- Sign up for a Stripe Account (do that here https://stripe.com)

- Get your server test key from your dashboard (do that here https://dashboard.stripe.com/account)

- Edit the `config/config.exs` file
```elixir
config :gateway, Stripex,
  url: "https://api.stripe.com",
  secret_key: YOUR_SECRET_KEY_HERE # looks something like "sk_test_sUkci83ae666fUcksAtan"
```
>fyi: the present secret_key is linked to my stripe test account, you can probably test with it (unless I reroll my keys in the future), but I advise you use your own since you'll be able to see Stripe's logs to see if things really worked or not.


- Manually setup a plan with id "test" (do that here https://dashboard.stripe.com/test/plans)

- You can now run the tests
```shell
mix deps.get
mix test
```

Be warned, these tests actually hit your stripe account (this is why we use the test one stripe stripe provides), so you'll need internet connection to run them.