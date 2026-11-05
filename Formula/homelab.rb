class Homelab < Formula
  desc "Terminal client for reviewed remote macOS setup and inspection"
  homepage "https://github.com/0x63616c/homelab-cli"
  url "https://github.com/0x63616c/homelab-cli/releases/download/v0.2.1/homelab-aarch64-apple-darwin.tar.gz"
  sha256 "4df63afb2147317f107d85f4d0af2aef962811d8eb08c07949307abaad3be380"

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
