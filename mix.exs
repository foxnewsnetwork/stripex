defmodule Stripex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stripex,
      version: "0.0.1",
      source_url: "https://github.com/foxnewsnetwork/stripex",
      elixir: "~> 1.0",
      deps: deps,
      description: description,
      package: package
    ]
  end

  def application do
    [applications: [:logger, :httpoison, :poison, :fox]]
  end

  defp deps do
    [{:httpoison, "~> 0.7"},
    {:poison, "~> 1.4.0"},
    {:fox, "~> 0.0.7"}]
  end

  defp description do
    """
    Wrapper around Stripe's API.

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
