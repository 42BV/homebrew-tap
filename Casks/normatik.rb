cask "normatik" do
  arch arm: "arm64", intel: "amd64"

  version "0.0.1"
  sha256 arm:   "513db90ea95a33c99d4b4c9b3191e5945bd6bdde98d17d92716b366f61b9cf8d",
         intel: "e08faea0090fed2213184d853d9f24dc1eeb97474ce63346468d077e1a0f164e"

  url "https://github.com/42BV/homebrew-tap/releases/download/normatik-cli-#{version}/normatik_#{version}_darwin_#{arch}.tar.gz"
  name "Normatik CLI"
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/homebrew-tap"

  binary "normatik"
  generate_completions_from_executable "normatik", shell_parameter_format: :cobra
end
