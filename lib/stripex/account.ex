defmodule Stripex.Account do
  @moduledoc """
  The Struct and type definition for a Stripex Account
  """

  @type t :: %Stripex.Account{
                      id: String.t,
                  object: String.t,
           business_name: String.t,
            display_name: String.t,
         charges_enabled: boolean,
       transfers_enabled: boolean,
       details_submitted: boolean,
    currencies_supported: list(String.t),
        default_currency: String.t,
                timezone: String.t,
    statement_descriptor: String.t,
                   email: String.t,
            business_url: String.t,
                 country: String.t,
           support_phone: String.t
  }

  defstruct           id: "",
                  object: "account",
            display_name: "",
           business_name: "",
         charges_enabled: false,
       transfers_enabled: false,
    currencies_supported: [ "usd" ],
        default_currency: "usd",
       details_submitted: false,
                timezone: "US/Pacific",
    statement_descriptor: "",
                   email: "",
            business_url: "",
                 country: "",
           support_phone: ""
end
