class Normatik < Formula
  desc "Command-line interface for the Normatik Public API"
  homepage "https://github.com/42BV/normatik-cli"
  url "https://github.com/42BV/normatik-cli/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "a85c78d0281247c76e90d60779c02afa8c7112570c271c793799d5904d5bd826"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/42BV/homebrew-tap/releases/download/normatik-1.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "18959d38afb90e40579324d68ecb5137ddd22b12ccd1cca5182623105566f472"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a0d184af72276b6ac5db5954b0322a3299acd173bf4639766dad8f058d56275a"
    sha256 cellar: :any_skip_relocation, tahoe:         "22708e35722d71af5fe9f5cc6c8d25ee49b1eb68976ef754564c0f34398ac081"
    sha256 cellar: :any_skip_relocation, sequoia:       "679702bb26b91f21aa189fecef837b340b63e15ee7d7e0c092f22092ceac44cb"
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
