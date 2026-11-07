class Homelab < Formula
  desc "Guided Mac setup from your Git configuration"
  homepage "https://github.com/0x63616c/homelab-cli"
  url "https://github.com/0x63616c/homelab-cli/releases/download/v0.4.1/homelab-aarch64-apple-darwin.tar.gz"
  sha256 "7e694795e8ad438ace32a550424919b826b620b7f7d655a2f5d7fda0a0a674d1"
  license "MIT"

  depends_on "age"
  depends_on arch: :arm64
  depends_on "gh"
  depends_on :macos
  depends_on "sops"

  deny_network_access!

  def install
    bin.install "homelab", "homelab-host"
    bin.install_symlink "homelab" => "hl"
  end

  test do
    assert_match "homelab #{version}", shell_output("#{bin}/homelab --version")
    assert_match "homelab #{version}", shell_output("#{bin}/hl --version")
    assert_match "homelab-host #{version}", shell_output("#{bin}/homelab-host --version")
    assert_match "Set up a Mac from your Git configuration", shell_output("#{bin}/homelab --help")
    output = shell_output("#{bin}/homelab setup --host example 2>&1", 2)
    assert_match "Setup needs an interactive terminal", output
  end
end
