defmodule Easter.MixProject do
  use Mix.Project

  @source_url "https://github.com/splagoon/easter"

  def project do
    [
      name: "Easter",
      app: :easter,
      version: "1.0.0",
      elixir: "~> 1.14",
      description: description(),
      package: package(),
      deps: deps(),
      source_url: @source_url,
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    """
    Simple library to get the date of Easter for a given year.
    """
  end

  defp package do
    [
      name: :easter,
      licenses: ["Unlicense"],
      links: %{GitHub: @source_url}
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
