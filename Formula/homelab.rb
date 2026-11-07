class Homelab < Formula
  desc "Guided Mac setup from your Git configuration"
  homepage "https://github.com/0x63616c/homelab-cli"
  url "https://github.com/0x63616c/homelab-cli/releases/download/v0.4.0/homelab-aarch64-apple-darwin.tar.gz"
  sha256 "d7dd9aa5c2411b39f702a340ff5038d55e335748aba9fe7ee057817a95946cbf"
  license "MIT"

  depends_on "age"
  depends_on arch: :arm64
  depends_on "gh"
  depends_on :macos
  depends_on "sops"

  deny_network_access!

  def install
    bin.install "homelab", "homelab-host"
  end

  test do
    assert_match "homelab #{version}", shell_output("#{bin}/homelab --version")
    assert_match "homelab-host #{version}", shell_output("#{bin}/homelab-host --version")
    assert_match "Set up a Mac from your Git configuration", shell_output("#{bin}/homelab --help")
    output = shell_output("#{bin}/homelab setup --host example 2>&1", 2)
    assert_match "Setup needs an interactive terminal", output
  end
end
