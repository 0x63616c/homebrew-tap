cask "callkeep" do
  version "1.0.20"
  sha256 "95bf80a6c2193bf759c6ab0305b65283fa4bba2e25f054089f10a348f6a1a9ee"

  url "https://github.com/0x63616c/callkeep/releases/download/v#{version}/Callkeep-#{version}.zip"
  name "Callkeep"
  desc "Record microphone and computer audio with optional iCloud Drive storage"
  homepage "https://github.com/0x63616c/callkeep"
  auto_updates true

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Callkeep.app"

  zap trash: [
    "~/Library/Preferences/co.calum.callkeep.plist",
    "~/Library/Saved Application State/co.calum.callkeep.savedState",
  ]
end
