class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "633143c148b28eb9bd9821f740fbf6523316e26c054c5db8fbbea0fa02013a4b"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-0.0.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f436b029b1bd47a84d19050fd0536355e788ca69f9a4267fcf87cc9a71d8f453"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ce70b32381c2716854c526e98651688a652d46aff110d3a1e765abbc4cd5d9af"
    sha256 cellar: :any_skip_relocation, tahoe:         "b6e98e84bb18d1340c0e10c869f00f06a2260ae00923408855f5ed408223fea3"
    sha256 cellar: :any_skip_relocation, sequoia:       "1b8ecd54e3fb397926ee1b41638a89edb58edbcbf32a6fcff534ee141667a541"
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
