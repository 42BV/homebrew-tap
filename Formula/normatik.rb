class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "732675888d1b3b991205e93ba2164bb4465a5ee6ab430313e13c58efb2ae7422"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-1.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aa997a11507ea61b4e7284e4b7ad888fb066e51ab251c759a18ab42b0fa23f53"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b6ba0ee8ab8853028e1bcbe02870f3a5ff9a6727449ed45d2c64cddce077c4f0"
    sha256 cellar: :any_skip_relocation, tahoe:         "c9108d06f57fb6f72fea0144d61b8396e58eee08296194c2ddca6d454941fc6d"
    sha256 cellar: :any_skip_relocation, sequoia:       "c1b6652d20c550a091ea79130482e0e2208a9a5260f210b593ead303f19fabe3"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/42BV/normatik-cli/internal/cli.version=#{version}"
    system "go", "build", "-trimpath", "-ldflags", ldflags, "-o", bin/"normatik", "./cmd/normatik"

    generate_completions_from_executable bin/"normatik", shell_parameter_format: :cobra
  end

  test do
    ENV["NORMATIK_CONFIG"] = testpath/"config.toml"
    assert_match "no environment configured", shell_output("#{bin}/normatik base-url 2>&1", 78)
  end
end
