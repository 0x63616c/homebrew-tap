class Homelab < Formula
  desc "Terminal client for reviewed remote macOS setup and inspection"
  homepage "https://github.com/0x63616c/homelab"
  url "https://github.com/0x63616c/homelab.git",
      revision: "542f47ae4fad86be2590ba61b005e382343fb986"
  version "0.1.4"

  depends_on "rust" => :build
  depends_on "age"
  depends_on arch: :arm64
  depends_on :macos
  depends_on "sops"

  deny_network_access!

  def fetch
    cd "client" do
      system "cargo", "fetch", *std_cargo_fetch_args
    end
  end

  def install
    cd "client" do
      system "cargo", "install", *std_cargo_args, "--bin", "homelab"
    end
  end

  test do
    assert_match "homelab #{version}", shell_output("#{bin}/homelab --version")
    assert_match "Guided remote homelab management", shell_output("#{bin}/homelab --help")
    output = shell_output("#{bin}/homelab --inventory #{testpath}/missing.json inspect --host example --json", 1)
    assert_equal "inventory-missing", JSON.parse(output).fetch("code")
  end
end
