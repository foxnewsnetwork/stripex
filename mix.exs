defmodule Stripex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stripex,
      version: "0.1.0",
      source_url: "https://github.com/foxnewsnetwork/stripex",
      elixir: "~> 1.0",
      deps: deps,
      description: description,
      package: package
    ]
  end

  def application do
    [applications: [:logger, :gateway]]
  end

  defp deps do
    [{:gateway, "~> 0.0.4"}]
  end

  defp description do
    """
    A much more ruby-stripe-like wrapper around Stripe's API (built with Poison).

    Full documentation can be found at https://stripe.com/docs/api
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{github: "https://github.com/foxnewsnetwork/stripex"},
      contributors: ["Chris Maddox", "Thomas Chen"]
    ]
  end
end
