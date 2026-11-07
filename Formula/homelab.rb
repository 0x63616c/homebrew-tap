class Homelab < Formula
  desc "Guided Mac setup from your Git configuration"
  homepage "https://github.com/0x63616c/homelab-cli"
  url "https://github.com/0x63616c/homelab-cli/releases/download/v0.3.1/homelab-aarch64-apple-darwin.tar.gz"
  sha256 "948595bfb8d856254fd7609cb1948f024b481b80f14ba7e87a02bee5ed5a60c5"
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
