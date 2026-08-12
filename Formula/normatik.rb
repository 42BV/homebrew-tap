class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "39d4eac11944eca6b729a2f5eb318df3a6a3e9d31bfb76a792e2c18a0580e91d"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-0.0.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f1ad16b05cb6d3e9d9c37b0ac1b9303b7055b6f8431b2bd1acebd7e824eb2185"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "91031b17f2d59ba9f37758258e5f58c0dc3c29cd69e1e3959deefaf6c0361d21"
    sha256 cellar: :any_skip_relocation, tahoe:         "bd374bc19bd6a6bac17aee0919d62740f1cfdaf47d147a1d80d3a09b7940aff4"
    sha256 cellar: :any_skip_relocation, sequoia:       "40fc199434dc65d7c60a1067ac52b1ef16675fb7d11e10ec44ca483b0f837fdb"
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
