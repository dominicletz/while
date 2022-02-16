defmodule While.MixProject do
  use Mix.Project

  def project do
    [
      app: :while,
      version: "0.2.4",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: """
        Provides a general functional `reduce_while(acc, fun)` for use without an Enum.
        Additionally provides syntax sugar to simulate a non-functional `while` as proof
        of concept on what can be done with macros.
      """,
      package: [
        licenses: ["Apache 2.0"],
        maintainers: ["Dominic Letz"],
        links: %{"GitHub" => "https://github.com/dominicletz/while"}
      ],
      # Docs
      name: "While",
      source_url: "https://github.com/dominicletz/while",
      docs: [
        # The main page in the docs
        main: "While",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [extra_applications: [:eex]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
