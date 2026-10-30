class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v1.10.1.tar.gz"
  sha256 "f9153bae35e42bd117d779aa58cc55829fba11b3a3d8df8e4a9a0818ce4025a5"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-1.10.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "dca53df63a921e7c229477b2b4535ad59bfd2ab9f9ae852d7ba3bc6b9f5d34d1"
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
