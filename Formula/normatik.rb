class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "5493c6264f2f8b0339bc670ab53fe4b4528e9c38590db8c9d6966eff4d1984a5"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/42bv/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "16dc502d3809ed0c2d1c3c0001e52dec07527de3d716ae2f6f339640381e5e6e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "400f3ed882968bec9d2c35a73afe81152fed9cd29044fa663210647656e15a3c"
    sha256 cellar: :any_skip_relocation, tahoe:         "5c57dd9e74e7d875d360bb54643a30773bf36ee085641032bc0dc910f1772906"
    sha256 cellar: :any_skip_relocation, sequoia:       "d50cbf72f341b46744ad7ef87acfcf7136b3bb38f66914a87167368ae70cab02"
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
