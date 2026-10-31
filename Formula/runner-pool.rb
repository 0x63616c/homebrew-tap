# typed: false
# frozen_string_literal: true

require_relative "../lib/github_private_release_download_strategy"

class RunnerPool < Formula
  desc "Isolated, reversible CI runner and Codex pool for Apple silicon Macs"
  homepage "https://github.com/0x63616c/runner-pool"
  url "https://github.com/0x63616c/runner-pool/releases/download/v0.7.1/runner-pool-aarch64-apple-darwin.tar.gz",
      using: GitHubPrivateReleaseDownloadStrategy
  version "0.7.1"
  sha256 "4f4a6d2421486fd9b50b2599713b489879272743768772f4d52f1d15acbbf580"
  license "MIT"

  livecheck do
    skip "Private repository; bumped by script/bump-runner-pool"
  end

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "runner-pool"
    bin.install_symlink "runner-pool" => "rp"
  end

  def caveats
    <<~EOS
      runner-pool's source repository is private. Homebrew downloads it with your
      GitHub login (`gh auth login`, or HOMEBREW_GITHUB_API_TOKEN).

      Set up this Mac as a runner-pool node (detects sizing, asks once before
      changing anything; preview with --dry-run):
        sudo rp setup
      Then check it any time with:
        rp status
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/runner-pool --version")
    assert_match version.to_s, shell_output("#{bin}/rp --version")
  end
end
