defmodule Stripex.Plan do
  @moduledoc """
  Stripe plan type
  """
  @type t :: %Stripex.Plan{
    interval: String.t,
    name: String.t,
    created: number,
    amount: number,
    currency: String.t,
    id: String.t,
    object: String.t,
    livemode: boolean,
    interval_count: number,
    trial_period_days: number | nil,
    metadata: map,
    statement_descriptor: String.t
  }

  defstruct interval: "month",
    name: "",
    created: 0,
    amount: 0,
    currency: "usd",
    id: "",
    object: "plan",
    livemode: false,
    interval_count: 1,
    trial_period_days: nil,
    metadata: %{},
    statement_descriptor: ""
end