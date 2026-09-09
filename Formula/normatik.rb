class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "788a4bb5ccd27add548be6338270e3027a74e134f33aa92afdb9ffa01f619dc9"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-1.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bb58e6a0039960d1c2c0756718c2a55802ecc93e1c5fe93f1803213b5d44e0f5"
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
