defmodule Stripex.Subscription do
  @moduledoc """
  Stripe Subscription type
  """
  @type t :: %Stripex.Subscription{
    id: String.t,
    plan: Stripex.Plan,
    object: String.t,
    start: integer,
    status: String.t,
    customer: String.t,
    cancel_at_period_end: integer,
    current_period_start: integer,
    current_period_end: integer,
    ended_at: integer,
    trial_start: integer,
    trial_end: integer,
    canceled_at: integer,
    quantity: integer,
    application_fee_percent: float,
    discount: map,
    tax_percent: float,
    metadata: map
  }

  defstruct id: "",
    plan: %Stripex.Plan{},
    object: "subscription",
    start: 0,
    status: "uninitialized",
    customer: "",
    cancel_at_period_end: false,
    current_period_start: 0,
    current_period_end: 0,
    ended_at: 0,
    trial_start: 0,
    trial_end: 0,
    canceled_at: 0,
    quantity: 0,
    application_fee_percent: 0.0,
    discount: %{},
    tax_percent: 0.0,
    metadata: %{}
end