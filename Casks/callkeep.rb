cask "callkeep" do
  version "1.0.26"
  sha256 "87e06b44d5a75142d614a17ff83f45382e9461f5d34667826355ac5da596c4db"

  url "https://github.com/0x63616c/world-wide-webb/releases/download/callkeep%2Fv#{version}/Callkeep-#{version}.zip"
  name "Callkeep"
  desc "Record microphone and computer audio with optional iCloud Drive storage"
  homepage "https://github.com/0x63616c/world-wide-webb"

  livecheck do
    url "https://github.com/0x63616c/world-wide-webb/releases"
    regex(%r{/releases/tag/callkeep(?:%2F|/)v?(\d+(?:\.\d+)+)}i)
    strategy :page_match
  end

  depends_on macos: :sequoia

  app "Callkeep.app"

  zap trash: [
    "~/Library/Preferences/co.calum.callkeep.plist",
    "~/Library/Saved Application State/co.calum.callkeep.savedState",
  ]
end
