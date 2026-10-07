class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "6cef8f118400715b40760167cc5bdd62efa4574e73aafd52c5dffdb98f0821fb"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-1.8.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "365c9722d2866f550093d0c70c3397ccfcfe4f4a64186e72ecbd79a3a85e5132"
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
