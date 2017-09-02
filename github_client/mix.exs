defmodule GithubClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :github_client,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      preferred_cli_env: [espec: :test],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      applications: [:httpotion]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpotion, "~> 3.0.2"},
      {:espec, "~> 1.4.5", only: :test}
    ]
  end
end
