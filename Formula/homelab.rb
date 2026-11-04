class Homelab < Formula
  desc "Terminal client for reviewed remote macOS setup and inspection"
  homepage "https://github.com/0x63616c/homelab-cli"
  url "https://github.com/0x63616c/homelab-cli/releases/download/v0.2.0/homelab-aarch64-apple-darwin.tar.gz"
  version "0.2.0"
  sha256 "9d4db97d7a4e220025b4e1a1eb899901e06825c43376692bcf5d643fc6c485e7"

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
    assert_match "Guided remote homelab management", shell_output("#{bin}/homelab --help")
    output = shell_output("#{bin}/homelab --inventory #{testpath}/missing.json inspect --host example --json", 1)
    assert_equal "inventory-missing", JSON.parse(output).fetch("code")
  end
end
