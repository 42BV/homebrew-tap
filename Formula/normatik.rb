class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "9a8ed8a563cc60fd44aa0b79e07b1869d8f4f21218bbda2c4f6c572772da6ce9"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-1.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b73f42c71a851fb0d2ebe19741bdae17d85807d069198eecad91c7dc3b5b779f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "799bc22e9a1a589f530b54d19f64d17bcc31f367d8c8c81ae055b96be593d0ec"
    sha256 cellar: :any_skip_relocation, tahoe:         "e2f4c5d388c35e8beb79ccaac80c9a7795f2ed77c5ebba56ee606691ea0fce90"
    sha256 cellar: :any_skip_relocation, sequoia:       "1323e95a0b8f6cbe750f2ac9330cacffd9197457eb8e9ac6b2ad70f2b56589cf"
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
