defmodule Stripex.Card do
  @moduledoc """
  The Struct and type spec information for a Stripex Card
  """
  @type t :: %Stripex.Card{
                     id: String.t,
                 object: String.t,
                  last4: String.t,
                  brand: String.t,
                funding: String.t,
              exp_month: number,
               exp_year: number,
            fingerprint: String.t,
                country: String.t,
                   name: String.t,
          address_line1: String.t,
          address_line2: String.t,
           address_city: String.t,
          address_state: String.t,
            address_zip: String.t,
        address_country: String.t,
              cvc_check: String.t,
    address_line1_check: String.t,
      address_zip_check: String.t,
          dynamic_last4: String.t,
               customer: String.t
  }

  defstruct          id: "",
                 object: "card",
                  last4: "",
                  brand: "",
                funding: "",
              exp_month: 0,
               exp_year: 0,
            fingerprint: "",
                country: "",
                   name: "",
          address_line1: "",
          address_line2: "",
           address_city: "",
          address_state: "",
            address_zip: "",
        address_country: "",
              cvc_check: "",
    address_line1_check: "",
      address_zip_check: "",
          dynamic_last4: "",
               customer: ""
end
