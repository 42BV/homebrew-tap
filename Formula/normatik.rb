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
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-0.0.4"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cb28bb3a35a385abdb5035ef08bf689d085a33d35264d43ef8f93d17ddc119b7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "531385ff43404be2cde5daf8147b8d7572f95ad13037ef1f0aaa7a14dbde4d7d"
    sha256 cellar: :any_skip_relocation, tahoe:         "c3805fd5366de50383a6b0b0e7f8c56cfaa36c2f99dd0cfbe9b02dd80c70c8ff"
    sha256 cellar: :any_skip_relocation, sequoia:       "34cd33f8aac440b42f8f4806f017c976abe15264b9153382e1666ca4780dea2b"
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
