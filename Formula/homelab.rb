class Homelab < Formula
  desc "Guided Mac setup from your Git configuration"
  homepage "https://github.com/0x63616c/world-wide-webb/tree/main/homelab/cli"
  url "https://github.com/0x63616c/world-wide-webb/releases/download/homelab%2Fv0.4.2/homelab-0.4.2.tar.gz"
  sha256 "34e8dcb4e8a72cf3c70b5c4ad4ad489ae1939be004eca177e33e5fa237cf4d82"
  version "0.4.2"
  license "MIT"

  livecheck do
    url "https://github.com/0x63616c/world-wide-webb/releases"
    regex(%r{/releases/tag/homelab(?:%2F|/)v?(\d+(?:\.\d+)+)}i)
    strategy :page_match
  end

  depends_on "age"
  depends_on arch: :arm64
  depends_on "gh"
  depends_on :macos
  depends_on "sops"
  deny_network_access!

  def install
    bin.install "bin/homelab", "bin/homelab-host"
    bin.install_symlink "homelab" => "hl"
    pkgshare.install Dir["share/homelab/*"]
  end

  test do
    assert_match "homelab #{version}", shell_output("#{bin}/homelab --version")
    assert_match "homelab #{version}", shell_output("#{bin}/hl --version")
    assert_match "homelab-host #{version}", shell_output("#{bin}/homelab-host --version")
  end
end
