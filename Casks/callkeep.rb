cask "callkeep" do
  version "1.0.29"
  sha256 "9e74f1e8bfd6521327df4fbdaf4d05600bb29183a801510651e2802d68fd1941"

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
