class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "f618663ff66824092a18a333a1f80120d9a53be02e305ef91a145bd83468c549"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-1.0.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "66ea10762d21a006cf6146d3bd60c22e1b7ef0ce8ed1b847057d71849fb9fd85"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f91ec6cbb64fd3ba1b97ee5e51c0c6f106114f4aaf9fe60037a9d447129b9907"
    sha256 cellar: :any_skip_relocation, tahoe:         "de348566f01f342b6ae9b1f493fd7cfe483b66086a714f4ed667ff07eee3b129"
    sha256 cellar: :any_skip_relocation, sequoia:       "77bbca26dec8854b26d4808ff038cd083bc3a90d73bea5dc9652d0cc87187591"
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
